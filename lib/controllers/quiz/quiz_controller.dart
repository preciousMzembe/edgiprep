import 'dart:math';

import 'package:edgiprep/models/lesson/question_answer_model.dart';
import 'package:edgiprep/models/lesson/slide_model.dart';
import 'package:edgiprep/models/lesson/lesson_slide_question_model.dart';
import 'package:edgiprep/services/quiz/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  QuizService quizService = QuizService();

  RxString quizId = "".obs;
  RxString subjectEnrollmentID = "".obs;

  final RxList<SlideModel> slides = <SlideModel>[].obs;

  // Tracks the list of slides and the currently visible slide index
  RxInt currentSlideIndex = 0.obs;
  RxList<SlideModel> visibleSlides = <SlideModel>[].obs;
  PageController pageController = PageController();

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
      saveQuestionScore(subjectEnrollmentID.value, quizId.string,
          visibleSlides[currentSlideIndex.value].question!.userAnswerId);

      // add slide
      if (currentSlideIndex.value < slides.length - 1) {
        visibleSlides.add(slides[currentSlideIndex.value + 1]);
      }

      visibleSlides.refresh();
    }
  }

  void goToNextSlide() {
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
  Future<bool> getData(String subjectEnrollmentId, int limit) async {
    bool error = false;

    Map data = await quizService.fetchData(subjectEnrollmentId, limit);

    if (data['error']) {
      error = true;
    } else {
      Map quizData = data['quizData'];

      quizId.value = quizData['quizId'];

      List<SlideModel> tempSlides = [];

      for (var question in quizData['questions']) {
        SlideModel tempSlide = SlideModel(
          question: LessonSlideQuestionModel(
            id: question['id'],
            questionText: question['name'],
            questionImage: question['imageUrL'],
            options: [],
            explanation: question['explaination'],
            explanationImage: question['explainationImage'],
          ),
        );

        List<QuestionAnswerModel> tempOptions = [];

        for (var option in question['answers']) {
          tempOptions.add(
            QuestionAnswerModel(
              id: option['id'],
              text: option['text'],
              qusetionId: option['questionId'],
              isCorrect: option['isCorrect'],
            ),
          );

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

  // Reset lesson progress
  Future<bool> restartLesson(String subjectEnrollmentId, int limit) async {
    subjectEnrollmentID.value = subjectEnrollmentId;
    bool error = await getData(subjectEnrollmentId, limit);

    currentSlideIndex.value = 0;
    visibleSlides.clear();
    resetSlides();
    loadInitialSlide();
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

  // save question score
  Future<void> saveQuestionScore(
      String sEnrollId, String qId, String aId) async {
    quizService.saveQuestionScore(sEnrollId, qId, aId);
  }

  // Save quiz score
  Future<void> saveQuizScore(int score) async {
    quizService.saveQuizScore(quizId.value, score);
  }
}
