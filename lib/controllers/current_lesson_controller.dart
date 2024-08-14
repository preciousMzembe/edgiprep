import 'dart:math';

import 'package:dio/dio.dart';
import 'package:edgiprep/models/lesson_slide.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentLessonController extends GetxController {
  // Rx variables to store quiz data
  final RxString _title = "".obs;
  final RxInt _currentSlideIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxList<LessonSlide> _slides = RxList<LessonSlide>([]);
  final RxInt _selectedIndex = RxInt(-1);
  final RxBool _checkAnswer = false.obs;
  final RxBool _done = false.obs;
  final RxBool _quizError = false.obs;

  // Getter methods for accessing data
  String get title => _title.value;
  int get currentSlideIndex => _currentSlideIndex.value;
  int get score => _score.value;
  List<LessonSlide> get slides => _slides.toList();
  int get numberOfSlides => _slides.length;
  int get selectedIndex => _selectedIndex.value;
  bool get checkAnswer => _checkAnswer.value;
  bool get done => _done.value;
  bool get quizError => _quizError.value;

  // Method to set parts of quiz

  void setTitle(String title) {
    _title.value = title;
  }

  void setSlides(List<LessonSlide> questions) {
    _slides.value = questions;
  }

  void setSampleQuetions() {
    _slides.value = sampleSlides;
  }

  void setCheckAnswer(bool check) {
    _checkAnswer.value = check;
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
  }

  void setQuizError(bool error) {
    _quizError.value = error;
  }

  void setDone(bool done) {
    _done.value = done;
  }

  void refreshPage() {
    setSelectedIndex(-1);
    setCheckAnswer(false);
  }

  // get number of questions
  int getNumberOfQuestions() {
    int questionCount = 0;

    for (var slide in slides) {
      if (slide.question != null) {
        questionCount++;
      }
    }

    return questionCount;
  }

  // slide
  void goToNextSlide() {
    _currentSlideIndex.value++;
  }

  // Method to check if the current question is the last one
  bool isLastSlide() => currentSlideIndex == slides.length - 1;

  // Method to handle user's answer selection
  void answerSelected(String userAnswer, String correctAnswer) async {
    // set user answer
    _slides[currentSlideIndex].question?.userAnswer = userAnswer;

    // correct or wrong
    if (userAnswer == correctAnswer) {
      _score.value++;
    }

    if (!isLastSlide()) {
      _currentSlideIndex.value++;
    }

    // uncheck answer
    refreshPage();
  }

  // Method to reset the quiz (optional)
  void resetQuiz() {
    _currentSlideIndex.value = 0;
    _score.value = 0;
    _done.value = false;

    // uncheck answer
    refreshPage();
  }

  // Create Lesson
  Future<void> createLesson(int lessonId) async {
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.get(
          "${ApiUrl!}/Lesson/GetLessonSlides?lessonId=$lessonId",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Set Lesson Slides
          var lessonData = response.data;

          // Set Lesson Slides
          List<LessonSlide> tempSlides = [];
          for (var i = 0; i < lessonData.length; i++) {
            var lessonSlide = lessonData[i];
            if (lessonSlide['slideType'] == 1) {
              // content slide
              LessonSlide contentSlide = LessonSlide(
                lessonId: lessonSlide['slideId'],
                content: lessonSlide['slideContent'],
              );

              tempSlides.add(contentSlide);
            } else {
              // question slide
              int questionId = int.parse(lessonSlide['slideContent']);

              // get question
              final questionResponse = await dio.get(
                "${ApiUrl!}/Question/$questionId",
                options: Options(
                  headers: headers,
                ),
              );

              if (questionResponse.statusCode == 200) {
                var questionData = questionResponse.data;

                List<String> options =
                    questionData['questionOptions'].split('<=>');
                options.shuffle(Random());

                LessonQuestion question = LessonQuestion(
                    question: questionData['questionText'],
                    options: options,
                    answer: questionData['questionAnswer']);

                // add question slide
                LessonSlide contentSlide = LessonSlide(
                  lessonId: lessonSlide['slideId'],
                  question: question,
                );

                tempSlides.add(contentSlide);
              }
            }
          }

          setSlides(tempSlides);
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        setQuizError(true);
        debugPrint(
            "error creating lesson -------------------------------- creating lesson");
      } else {
        // Other errors like network issues
        setQuizError(true);
        debugPrint(
            "error creating lesson -------------------------------- creating lesson - connection");
      }
    } catch (e) {
      // Handle any exceptions
      setQuizError(true);
      print(e);
      debugPrint(
          "error creating lesson -------------------------------- creating lesson - error occured");
    }
  }
}

// Sample biology quiz questions (Multiple Choice)
final List<LessonSlide> sampleSlides = [
  LessonSlide(
    lessonId: 1,
    content: 'This is the introduction to the lesson.',
  ),
  LessonSlide(
    lessonId: 2,
    question: LessonQuestion(
      question: 'Which of the following is the basic unit of life?',
      options: ['Cell', 'Organ', 'Tissue', 'System'],
      answer: 'Cell',
    ),
  ),
  LessonSlide(
    lessonId: 3,
    content:
        'Photosynthesis is the process used by plants to convert light energy into chemical energy.',
  ),
  // LessonSlide(
  //   lessonId: 4,
  //   question: LessonQuestion(
  //     question:
  //         'What process uses sunlight, water, and carbon dioxide to produce glucose and oxygen?',
  //     options: ['Cellular respiration', 'Photosynthesis', 'Mitosis', 'Meiosis'],
  //     answer: 'Photosynthesis',
  //   ),
  // ),
];
