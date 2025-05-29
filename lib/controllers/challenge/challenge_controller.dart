import 'dart:math';

import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/models/lesson/question_answer_model.dart';
import 'package:edgiprep/models/lesson/slide_model.dart';
import 'package:edgiprep/models/lesson/lesson_slide_question_model.dart';
import 'package:edgiprep/services/challenge/challenge_service.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeController extends GetxController {
  ChallengeService challengeService = Get.find<ChallengeService>();
  ConfigService configService = Get.find<ConfigService>();

  late Config? config;

  RxString subjectEnrollmentID = "".obs;
  RxString quizId = "".obs;
  RxList<String> answerIds = <String>[].obs;

  final RxList<SlideModel> slides = <SlideModel>[].obs;

  // Tracks the list of slides and the currently visible slide index
  RxInt currentSlideIndex = 0.obs;
  RxList<SlideModel> visibleSlides = <SlideModel>[].obs;
  PageController pageController = PageController();

  @override
  void onInit() async {
    super.onInit();

    config = await configService.getConfig();
    config ??= await configService.getConfig();
  }

  // Load the first slide initially
  void loadInitialSlide() {
    if (slides.isNotEmpty) {
      visibleSlides.add(slides.first);
    }
  }

  // Move to the next slide and make it visible
  void markSlideDone() {
    if (!visibleSlides[currentSlideIndex.value].slideDone) {
      // if not, mark done and add next slide
      visibleSlides[currentSlideIndex.value].slideDone = true;

      // save question progress
      if (visibleSlides[currentSlideIndex.value].question != null) {
        answerIds
            .add(visibleSlides[currentSlideIndex.value].question!.userAnswerId);
      }

      // // add slide
      if (currentSlideIndex.value < slides.length - 1) {
        visibleSlides.add(slides[currentSlideIndex.value + 1]);
      }

      visibleSlides.refresh();
    }
  }

  void goToNextSlide() {
    // check number of left slides
    if ((slides.length - visibleSlides.length) <= 4) {
      // get new questions
      getNewData();
    }

    if (currentSlideIndex.value < slides.length - 1) {
      // check if current slide is done
      if (!visibleSlides[currentSlideIndex.value].slideDone) {
        // if not, mark done and add next slide
        visibleSlides[currentSlideIndex.value].slideDone = true;
        visibleSlides.add(slides[currentSlideIndex.value + 1]);
      }

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
    }
  }

  // Get quiz data
  Future<bool> getData(String subjectEnrollmentId) async {
    bool error = false;

    Map data = await challengeService.fetchData(subjectEnrollmentId);

    if (data['error']) {
      error = true;
    } else {
      Map quizData = data['quizData'];

      if (quizData['questions'] == null || quizData['questions'].isEmpty) {
        return true;
      }

      quizId.value = quizData['quizId'];

      List<SlideModel> tempSlides = [];

      for (var question in quizData['questions']) {
        String explanation = question['explaination'] != null
            ? question['explaination'].replaceAll(RegExp(r'<[^>]*>'), '').trim()
            : "";

        SlideModel tempSlide = SlideModel(
          question: LessonSlideQuestionModel(
            id: question['id'],
            questionText: question['name'],
            questionImage:
                question['imageUrL'] != null && question['imageUrL'] != ""
                    ? "${config?.imagesUrl}/${question['imageUrL']}"
                    : "",
            options: [],
            explanation: explanation != "" ? question['explaination'] : "",
            explanationImage: question['explainationImage'] != null &&
                    question['explainationImage'] != ""
                ? "${config?.imagesUrl}/${question['explainationImage']}"
                : "",
          ),
        );

        List<QuestionAnswerModel> tempOptions = [];

        for (var option in question['answers']) {
          // Remove HTML tags using a regular expression
          String cleanContent =
              option['text'].replaceAll(RegExp(r'<[^>]*>'), '').trim();

          if (cleanContent.isNotEmpty ||
              (option['imageUrl'] != null && option['imageUrl'] != "")) {
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

        tempSlides.add(tempSlide);
      }

      slides.value = tempSlides;
    }

    return error;
  }

  Future<void> getNewData() async {
    Map data = await challengeService.fetchNewData(
        subjectEnrollmentID.value, quizId.value);

    if (data['error']) {
      // use old questions
      List<SlideModel> tempSlides = [];

      for (var slide in slides) {
        SlideModel newSlide = SlideModel(
          question: LessonSlideQuestionModel(
            id: slide.question!.id,
            questionText: slide.question!.questionText,
            questionImage: slide.question!.questionImage,
            explanation: slide.question!.explanation,
            explanationImage: slide.question!.explanationImage,
            options: [],
          ),
        );

        List<QuestionAnswerModel> tempOptions = [];

        for (var option in slide.question!.options) {
          // Remove HTML tags using a regular expression
          String cleanContent =
              option.text.replaceAll(RegExp(r'<[^>]*>'), '').trim();

          if (cleanContent.isNotEmpty ||
              (option.image != null && option.image != "")) {
            tempOptions.add(
              QuestionAnswerModel(
                id: option.id,
                text: option.text,
                image: option.image,
                qusetionId: option.qusetionId,
                isCorrect: option.isCorrect,
              ),
            );
          }

          if (option.isCorrect) {
            newSlide.question!.setCorrectUserAnswer(option.id);
          }
        }

        tempOptions.shuffle(Random());

        newSlide.question!.setOptions(tempOptions);

        tempSlides.add(newSlide);
      }

      tempSlides.shuffle(Random());

      slides.addAll(tempSlides);
      slides.refresh();
    } else {
      Map quizData = data['quizData'];

      List<SlideModel> tempSlides = [];

      for (var question in quizData['questions']) {
        String explanation = question['explaination'] != null
            ? question['explaination'].replaceAll(RegExp(r'<[^>]*>'), '').trim()
            : "";

        SlideModel tempSlide = SlideModel(
          question: LessonSlideQuestionModel(
            id: question['id'],
            questionText: question['name'],
            questionImage:
                question['imageUrL'] != null && question['imageUrL'] != ""
                    ? "${config?.imagesUrl}/${question['imageUrL']}"
                    : "",
            options: [],
            explanation: explanation != "" ? question['explaination'] : "",
            explanationImage: question['explainationImage'] != null &&
                    question['explainationImage'] != ""
                ? "${config?.imagesUrl}/${question['explainationImage']}"
                : "",
          ),
        );

        List<QuestionAnswerModel> tempOptions = [];

        for (var option in question['answers']) {
          // Remove HTML tags using a regular expression
          String cleanContent =
              option['text'].replaceAll(RegExp(r'<[^>]*>'), '').trim();

          if (cleanContent.isNotEmpty ||
              (option['imageUrl'] != null && option['imageUrl'] != "")) {
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

        tempSlides.add(tempSlide);
      }

      slides.addAll(tempSlides);
      slides.refresh();
    }
  }

  // Reset quiz
  Future<bool> restartQuiz(String subjectEnrollmentId) async {
    subjectEnrollmentID.value = subjectEnrollmentId;
    bool error = await getData(subjectEnrollmentId);

    currentSlideIndex.value = 0;
    visibleSlides.clear();
    resetSlides();
    loadInitialSlide();
    resetPageController();
    answerIds.value = [];

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

  // save question score
  Future<void> saveQuestionScores() async {
    challengeService.saveQuestionScores(
        subjectEnrollmentID.value, quizId.value, answerIds);
  }

  // Save quiz score
  Future<void> saveQuizScore(int score) async {
    challengeService.saveQuizScore(quizId.value, score);
  }
}
