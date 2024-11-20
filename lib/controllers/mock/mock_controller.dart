import 'package:edgiprep/models/lesson/slide_model.dart';
import 'package:edgiprep/models/lesson/lesson_slide_question_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MockController extends GetxController {
  final RxList<SlideModel> slides = [
    SlideModel(
      question: LessonSlideQuestionModel(
        questionText:
            "The following are characteristics of a good drawing except?",
        options: [
          "They should be large enough",
          "They are not drawn to scale",
          "They should be accurate",
          "They should be neat",
        ],
        explanation:
            "A good drawing  should accurately represent the subject, including proportions and measurements. Not drawing to scale distorts the representation, making it unreliable for analysis or understanding.",
        correctAnswer: "They are not drawn to scale",
      ),
    ),
    SlideModel(
      question: LessonSlideQuestionModel(
        questionText:
            "What is the most important step when starting a biological diagram?",
        options: [
          "Adding labels first",
          "Drawing lightly to outline proportions",
          "Using bold lines immediately",
          "Skipping the title",
        ],
        explanation:
            "A good drawing  should accurately represent the subject, including proportions and measurements. Not drawing to scale distorts the representation, making it unreliable for analysis or understanding.",
        correctAnswer: "Drawing lightly to outline proportions",
      ),
    ),
  ].obs;

  // Tracks the list of slides and the currently visible slide index
  RxInt currentSlideIndex = 0.obs;
  RxList<SlideModel> visibleSlides = <SlideModel>[].obs;
  PageController pageController = PageController();

  void getData() {}

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

  // Reset lesson progress (optional)
  void restartLesson() {
    currentSlideIndex.value = 0;
    visibleSlides.clear();
    resetSlides();
    loadInitialSlide();
    resetPageController();
  }

  void resetSlides() {
    for (var slide in slides) {
      slide.slideDone = false;
      slide.question?.userAnswer = "";
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
    return slide.question != null && slide.question!.userAnswer.isNotEmpty;
  }

  // Answer the current slide's question
  void answerCurrentQuestion(String answer) {
    final currentSlide = slides[currentSlideIndex.value];
    if (currentSlide.question != null) {
      currentSlide.question!.userAnswer = answer;
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
      if (slide.question != null &&
          slide.question?.correctAnswer == slide.question?.userAnswer) {
        number++;
      }
    }
    return number;
  }
}
