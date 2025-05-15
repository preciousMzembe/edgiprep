import 'dart:math';

import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/models/lesson/question_answer_model.dart';
import 'package:edgiprep/models/lesson/slide_content_model.dart';
import 'package:edgiprep/models/lesson/slide_media_model.dart';
import 'package:edgiprep/models/lesson/slide_model.dart';
import 'package:edgiprep/models/lesson/lesson_slide_question_model.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/services/lesson/lesson_service.dart';
import 'package:edgiprep/services/stats/stats_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonController extends GetxController {
  ConfigService configService = Get.find<ConfigService>();
  StatsService statsService = Get.find<StatsService>();
  LessonService lessonService = Get.find<LessonService>();

  late Config? config;

  RxString subjectEnrollmentID = "".obs;

  final RxList<SlideModel> slides = <SlideModel>[].obs;

  // Tracks the list of slides and the currently visible slide index
  RxInt currentSlideIndex = 0.obs;
  RxBool firstJump = true.obs;
  RxList<SlideModel> visibleSlides = <SlideModel>[].obs;
  PageController pageController = PageController();

  @override
  Future<void> onInit() async {
    super.onInit();
    config = await configService.getConfig();
    config ??= await configService.getConfig();
  }

  // Load the first slide initially
  Future<void> loadInitialSlide() async {
    firstJump.value = true;

    if (slides.isNotEmpty) {
      if (currentSlideIndex.value == 0) {
        visibleSlides.add(slides.first);
      } else {
        for (var i = 0; i < currentSlideIndex.value + 1; i++) {
          visibleSlides.add(slides[i]);
        }
      }
    }
  }

  // Move to the next slide and make it visible
  void markSlideDone() {
    if (!visibleSlides[currentSlideIndex.value].slideDone) {
      // if not, mark done and add next slide
      visibleSlides[currentSlideIndex.value].slideDone = true;

      // save slide progress
      saveSlideProgress(
        subjectEnrollmentID.value,
        visibleSlides[currentSlideIndex.value].id ?? "",
        visibleSlides[currentSlideIndex.value].question != null
            ? visibleSlides[currentSlideIndex.value].question!.userAnswerId
            : "",
        visibleSlides[currentSlideIndex.value].question != null
            ? visibleSlides[currentSlideIndex.value].question!.userAnswerId ==
                visibleSlides[currentSlideIndex.value].question!.correctAnswerId
            : false,
      );

      visibleSlides.refresh();
    }
  }

  void goToNextSlide() {
    // check if current slide is done
    if (!visibleSlides[currentSlideIndex.value].slideDone) {
      // if not, mark done and add next slide
      // save question progress
      saveSlideProgress(
        subjectEnrollmentID.value,
        visibleSlides[currentSlideIndex.value].id ?? "",
        visibleSlides[currentSlideIndex.value].question != null
            ? visibleSlides[currentSlideIndex.value].question!.userAnswerId
            : "",
        visibleSlides[currentSlideIndex.value].question != null
            ? visibleSlides[currentSlideIndex.value].question!.userAnswerId ==
                visibleSlides[currentSlideIndex.value].question!.correctAnswerId
            : false,
      );

      visibleSlides[currentSlideIndex.value].slideDone = true;
    }

    if (currentSlideIndex.value < slides.length - 1) {
      visibleSlides.add(slides[currentSlideIndex.value + 1]);

      visibleSlides.refresh();

      // jump to next
      currentSlideIndex.value++;
      pageController.animateToPage(
        currentSlideIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Move to the previous slide (user can scroll back freely)
  void goToPreviousSlide() {
    if (currentSlideIndex.value > 0) {
      currentSlideIndex.value--;
      pageController.animateToPage(
        currentSlideIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      visibleSlides.removeLast();
    }
  }

  // Fetch the lesson data
  Future<bool> getData(Topic topic, Lesson lesson) async {
    bool error = false;

    Map data = await lessonService.fetchData(topic, lesson);

    if (data['error']) {
      error = true;
    } else {
      if (data['lessonData'] == null || data['lessonData'].isEmpty) {
        return true;
      }

      List<SlideModel> tempSlides = [];

      for (var slide in data['lessonData']) {
        // prepare slide

        bool hasMedia = false;
        SlideMediaModel tempSlideMedia = SlideMediaModel(MediaType.image, "");
        if (slide['media'] != null && slide['media'].isNotEmpty) {
          tempSlideMedia = SlideMediaModel(
              MediaType.image, "${config?.imagesUrl}/${slide['media']}");
          hasMedia = true;
        }

        SlideContentModel tempSlideContent = SlideContentModel(
          title: slide['title'] ?? "",
          text: slide['description'] ?? "",
          slideMedia: hasMedia ? tempSlideMedia : null,
        );

        String explanation = slide['question'] != null
            ? slide['question']['explaination']
                .replaceAll(RegExp(r'<[^>]*>'), '')
                .trim()
            : "";

        // Slide
        SlideModel tempSlide = SlideModel(
          order: slide['order'],
          id: slide['id'],
          content: tempSlideContent,
          question: slide['question'] == null
              ? null
              : LessonSlideQuestionModel(
                  id: slide['question']['id'] ?? "",
                  questionText: slide['question']['name'],
                  questionImage: slide['question']['imageUrL'] != null &&
                          slide['question']['imageUrL'] != ""
                      ? "${config?.imagesUrl}/${slide['question']['imageUrL']}"
                      : "",
                  options: [],
                  explanation: explanation,
                  explanationImage: slide['question']['explainationImage'] !=
                              null &&
                          slide['question']['explainationImage'] != ""
                      ? "${config?.imagesUrl}/${slide['question']['explainationImage']}"
                      : "",
                ),
          slideDone: slide['isDone'] ?? false,
        );

        // Question options
        if (slide['question'] != null) {
          List<QuestionAnswerModel> tempOptions = [];

          for (var option in slide['question']['answers']) {
            // Remove HTML tags using a regular expression
            String cleanContent =
                option['text'].replaceAll(RegExp(r'<[^>]*>'), '').trim();

            if (cleanContent.isNotEmpty ||
                option['imageUrl'] != null && option['imageUrl'] != "") {
              tempOptions.add(
                QuestionAnswerModel(
                  id: option['id'],
                  text: cleanContent.isEmpty ? cleanContent : option['text'],
                  image: option['imageUrl'] != null && option['imageUrl'] != ""
                      ? "${config?.imagesUrl}/${option['imageUrl']}"
                      : "",
                  qusetionId: option['questionId'],
                  isCorrect: option['isCorrect'],
                ),
              );
            }

            if (option['isCorrect']) {
              tempSlide.question!.setCorrectUserAnswer(option['id']);
            }
          }

          // shuffle options before adding
          tempOptions.shuffle(Random());

          tempSlide.question!.setOptions(tempOptions);
        }

        // check if slide is done
        if (slide['isDone'] != null && slide['isDone']) {
          if (slide['answer'] != null && slide['question'] != null) {
            tempSlide.question!.userAnswerId = slide['answer']['id'];
          }
        }

        tempSlides.add(tempSlide);
      }

      tempSlides.sort((a, b) => a.order!.compareTo(b.order as num));

      // check starting point
      int startIndex = 0;
      bool newSlide = false;
      for (var slide in tempSlides) {
        if (slide.slideDone && !newSlide) {
          startIndex++;
        }

        if (!slide.slideDone) {
          newSlide = true;
        }
      }

      if (startIndex == tempSlides.length) {
        currentSlideIndex.value = 0;
      } else {
        currentSlideIndex.value = startIndex;
      }

      // currentSlideIndex.refresh();

      // assign data
      slides.value = tempSlides;
    }

    return error;
  }

  // Reset lesson progress (optional)
  Future<bool> restartLesson(Topic topic, Lesson lesson) async {
    visibleSlides.clear();

    subjectEnrollmentID.value = topic.subjectEnrollmentId;
    bool error = await getData(topic, lesson);

    // currentSlideIndex.value = 0;
    // resetSlides();
    await loadInitialSlide();
    resetPageController();

    return error;
  }

  void resetSlides() {
    for (var slide in slides) {
      slide.slideDone = false;
      slide.question?.userAnswerId = "";
    }
  }

  void resetPageController() {
    pageController.dispose();
    pageController = PageController(initialPage: 0);
    update();
  }

  // Check if the current slide has a question and mark it answered if required
  bool isQuestionAnswered(int index) {
    final slide = slides[index];
    return slide.question != null && slide.question!.userAnswerId.isNotEmpty;
  }

  // Answer the current slide's question
  void answerCurrentQuestion(String answer) {
    final currentSlide = slides[currentSlideIndex.value];
    if (currentSlide.question != null) {
      currentSlide.question!.userAnswerId = answer;
      visibleSlides.refresh();
    }
  }

  // check if is last slide
  bool isLastSlide() {
    return currentSlideIndex.value == (slides.length - 1);
  }

  // get number of question
  int getNumberOfQuestions() {
    int number = 0;
    for (var slide in slides) {
      if (slide.question != null) {
        number++;
      }
    }
    return number;
  }

  // get correct answers
  int getCorrectAnswers() {
    int number = 0;
    for (var slide in slides) {
      if (slide.question != null) {
        for (var option in slide.question!.options) {
          if (option.isCorrect && option.id == slide.question!.userAnswerId) {
            number++;
          }
        }
      }
    }
    return number;
  }

  // Save slide progress
  Future<void> saveSlideProgress(
      String sEnrollId, String sId, String aId, bool correct) async {
    bool error = await lessonService.saveSlideProgress(sEnrollId, sId, aId);

    // save xp
    if (correct && !error) {
      await statsService.saveXps(1);
    }

    // Update Streak
    statsService.saveStreak();
  }
}
