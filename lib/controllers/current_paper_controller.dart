import 'dart:math';

import 'package:dio/dio.dart';
import 'package:edgiprep/models/test_question.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentPaperController extends GetxController {
  // Rx variables to store quiz data
  final RxString _title = "".obs;
  final RxInt _currentQuestionIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxList<TestQuestion> _questions = RxList<TestQuestion>([]);
  final RxInt _totalQuestions = 0.obs;
  final RxInt _selectedIndex = RxInt(-1);
  final RxBool _checkAnswer = false.obs;
  final RxList<TestQuestion> _wrongQuestions = RxList<TestQuestion>([]);
  final RxBool _done = false.obs;
  final RxBool _paperError = false.obs;
  final RxBool _timeAlmostUp = false.obs;

  // Getter methods for accessing data
  String get title => _title.value;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get score => _score.value;
  List<TestQuestion> get questions => _questions.toList();
  int get totalQuestions => _totalQuestions.value;
  int get numberOfQuestions => _questions.length;
  int get selectedIndex => _selectedIndex.value;
  bool get checkAnswer => _checkAnswer.value;
  List<TestQuestion> get wrongQuestions => _wrongQuestions.toList();
  bool get done => _done.value;
  bool get paperError => _paperError.value;
  bool get timeAlmostUp => _timeAlmostUp.value;

  // Method to set parts of quiz

  void setTitle(String title) {
    _title.value = title;
  }

  void setQuestions(List<TestQuestion> questions) {
    _questions.value = questions;
  }

  void setSampleQuetions() {
    _questions.value = sampleQuestions;
  }

  void addCorrectionQuestion(TestQuestion question) {
    _wrongQuestions.add(question);
  }

  void emptyWrongQuestions() {
    _wrongQuestions.value = [];
  }

  void setCheckAnswer(bool check) {
    _checkAnswer.value = check;
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
  }

  void setDone(bool done) {
    _done.value = done;
  }

  void setPaperError(bool error) {
    _paperError.value = error;
  }

  void setTimeAlmostUp(bool timeUp) {
    _timeAlmostUp.value = timeUp;
  }

  void refreshPage() {
    setSelectedIndex(-1);
    setCheckAnswer(false);
  }

  // Get Paper Questions
  Future<void> getPaperQuestions(int paperId) async {
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.get(
          "${ApiUrl!}/PastPaper/PastPaperQuestions?pastPaperId=$paperId",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Set Questions
          var responseData = response.data;

          List<TestQuestion> tempQuestions = [];
          for (var i = 0; i < responseData.length; i++) {
            List<String> options =
                responseData[i]['questionOptions'].split('<=>');
            options.shuffle(Random());

            TestQuestion question = TestQuestion(
              questionId: responseData[i]['questionId'],
              question: responseData[i]['questionText'],
              options: options,
              answer: responseData[i]['questionAnswer'],
              userAnswer: '',
            );

            tempQuestions.add(question);
          }

          setQuestions(tempQuestions);

          // set total questions for xps
          _totalQuestions.value = tempQuestions.length;
          if (totalQuestions == 0) {
            setPaperError(true);
          }
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        setPaperError(true);
        debugPrint(
            "error getting mock questions -------------------------------- getting mock questions");
      } else {
        // Other errors like network issues
        setPaperError(true);
        debugPrint(
            "error getting mock questions -------------------------------- getting mock questions - connection");
      }
    } catch (e) {
      // Handle any exceptions
      setPaperError(true);
      debugPrint(
          "error getting mock questions -------------------------------- getting mock questions - error occured");
    }
  }

  // Method to check if the current question is the last one
  bool isLastQuestion() => currentQuestionIndex == questions.length - 1;

  // Method to handle user's answer selection
  void answerSelected(String userAnswer, String correctAnswer) async {
    // set user answer
    _questions[currentQuestionIndex].userAnswer = userAnswer;

    // correct or wrong
    if (userAnswer == correctAnswer) {
      _score.value++;
    } else {
      // add wrong question
      addCorrectionQuestion(questions[_currentQuestionIndex.value]);
    }
  }

  // continue with paper
  void continuePaper() {
    if (!isLastQuestion()) {
      _currentQuestionIndex.value++; // Move to the next question
    }

    // uncheck answer
    refreshPage();
  }

  // Method to reset the quiz (optional)
  void resetQuiz() {
    _currentQuestionIndex.value = 0;
    _score.value = 0;
    _done.value = false;
    _timeAlmostUp.value = false;

    // uncheck answer
    refreshPage();
  }
}

// Sample biology quiz questions (Multiple Choice)
final List<TestQuestion> sampleQuestions = [
  TestQuestion(
    questionId: 1,
    question: "Which of the following is the basic unit of life?",
    options: ["Cell", "Organ", "Tissue", "System"],
    answer: "Cell",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 2,
    question:
        "What process uses sunlight, water, and carbon dioxide to produce glucose and oxygen?",
    options: ["Cellular respiration", "Photosynthesis", "Mitosis", "Meiosis"],
    answer: "Photosynthesis",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 3,
    question: "What is the function of DNA?",
    options: [
      "To transport materials within the cell",
      "To store genetic information",
      "To provide energy for the cell",
      "To build proteins"
    ],
    answer: "To store genetic information",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 4,
    question:
        "What is the process by which an organism inherits traits from its parents?",
    options: ["Adaptation", "Evolution", "Heredity", "Homeostasis"],
    answer: "Heredity",
    userAnswer: "",
  ),
  TestQuestion(
    questionId: 5,
    question:
        "What are the structures in a plant cell that capture sunlight for photosynthesis?",
    options: ["Nucleus", "Chloroplasts", "Mitochondria", "Cell wall"],
    answer: "Chloroplasts",
    userAnswer: "",
  ),
  // const TestQuestion(
  // questionId: 6,
  //   question: "What is the waste product of cellular respiration?",
  //   options: ["Glucose", "Oxygen", "Carbon dioxide", "Water"],
  //   answer: "Carbon dioxide",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 7,
  //   question: "What is the function of the digestive system?",
  //   options: [
  //     "To remove waste products from the body",
  //     "To transport materials throughout the body",
  //     "To break down food into smaller molecules",
  //     "To control the body's temperature"
  //   ],
  //   answer: "To break down food into smaller molecules",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 8,
  //   question: "What is the difference between arteries and veins?",
  //   options: [
  //     "Arteries carry oxygen-rich blood, veins carry oxygen-depleted blood.",
  //     "Veins carry oxygen-rich blood, arteries carry oxygen-depleted blood.",
  //     "Arteries are thinner and less muscular than veins.",
  //     "Veins are thinner and less muscular than arteries."
  //   ],
  //   answer:
  //       "Arteries carry oxygen-rich blood, veins carry oxygen-depleted blood.",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 9,
  //   question: "What is the role of enzymes in the body?",
  //   options: [
  //     "To provide energy",
  //     "To speed up chemical reactions",
  //     "To build structures",
  //     "To transport materials"
  //   ],
  //   answer: "To speed up chemical reactions",
  // userAnswer: "",
  // ),
  // const TestQuestion(
  // questionId: 10,
  //   question:
  //       "What is the process by which plants lose water vapor through their leaves?",
  //   options: [
  //     "Transpiration",
  //     "Cellular respiration",
  //     "Photosynthesis",
  //     "Mitosis"
  //   ],
  //   answer: "Transpiration",
  // userAnswer: "",
  // ),
];
