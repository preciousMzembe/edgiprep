import 'dart:math';

import 'package:dio/dio.dart';
import 'package:edgiprep/models/question.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentChallangeController extends GetxController {
  // Rx variables to store quiz data
  final RxString _title = "".obs;
  final RxInt _quizId = 0.obs;
  final RxInt _currentQuestionIndex = 0.obs;
  final RxInt _score = 0.obs;
  final RxList<Question> _questions = RxList<Question>([]);
  final RxInt _totalQuestions = 0.obs;
  final RxInt _selectedIndex = RxInt(-1);
  final RxBool _checkAnswer = false.obs;
  final RxList<Question> _wrongQuestions = RxList<Question>([]);
  final RxBool _correctionRound = false.obs;
  final RxBool _quizError = false.obs;

  // Getter methods for accessing data
  String get title => _title.value;
  int get quizId => _quizId.value;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get score => _score.value;
  List<Question> get questions => _questions.toList();
  int get totalQuestions => _totalQuestions.value;
  int get numberOfQuestions => _questions.length;
  int get selectedIndex => _selectedIndex.value;
  bool get checkAnswer => _checkAnswer.value;
  List<Question> get wrongQuestions => _wrongQuestions.toList();
  bool get correctionRound => _correctionRound.value;
  bool get quizError => _quizError.value;

  // Method to set parts of quiz

  void setTitle(String title) {
    _title.value = title;
  }

  void setQuizId(int id) {
    _quizId.value = id;
  }

  void setQuestions(List<Question> questions) {
    _questions.value = questions;
  }

  void setSampleQuetions() {
    _questions.value = sampleQuestions;
  }

  void addCorrectionQuestion(Question question) {
    _wrongQuestions.add(question);
  }

  void emptyWrongQuestions() {
    _wrongQuestions.value = [];
  }

  void setCorrectionQuestions() {
    _questions.value = _wrongQuestions;
  }

  void setCorrectionRound(bool correction) {
    _correctionRound.value = correction;
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

  void refreshPage() {
    setSelectedIndex(-1);
    setCheckAnswer(false);
  }

  // Method to check if the current question is the last one
  bool isTwoQuestionsToFinish() => currentQuestionIndex == questions.length - 3;

  // Method to handle user's answer selection
  void answerSelected(String userAnswer, String correctAnswer) {
    // correct or wrong
    if (userAnswer == correctAnswer) {
      _score.value++;
    } else {
      // add correction question if is not correction round
      if (!correctionRound) {
        addCorrectionQuestion(questions[_currentQuestionIndex.value]);
      }
    }

    if (isTwoQuestionsToFinish()) {
      // Add Questions
      addQuizQuestions();
    }

    // Next Question
    _currentQuestionIndex.value++;

    // uncheck answer
    refreshPage();
  }

  // Method to reset the quiz (optional)
  void resetQuiz() {
    _currentQuestionIndex.value = 0;
    _score.value = 0;

    // uncheck answer
    refreshPage();
  }

  // Create Quiz
  Future<void> createQuiz(int instanceId) async {
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.post(
          "${ApiUrl!}/CreateTest?InstanceId=$instanceId&type=quiz",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Set quiz id
          var quizId = response.data;
          setQuizId(quizId);

          // Get Quiz Questions
          await getQuizQuestions();
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        setQuizError(true);
        debugPrint(
            "error creating quiz -------------------------------- creating quiz");
      } else {
        // Other errors like network issues
        setQuizError(true);
        debugPrint(
            "error creating quiz -------------------------------- creating quiz - connection");
      }
    } catch (e) {
      // Handle any exceptions
      setQuizError(true);
      debugPrint(
          "error creating quiz -------------------------------- creating quiz - error occured");
    }
  }

  // Get Quiz Questions
  Future<void> getQuizQuestions() async {
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.get(
          "${ApiUrl!}/TestQuestion?TestId=$quizId&Limit=$QuizQuestionNumber",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Set Questions
          var responseData = response.data;

          List<Question> tempQuestions = [];
          for (var i = 0; i < responseData.length; i++) {
            List<String> options =
                responseData[i]['questionOptions'].split('<=>');
            options.shuffle(Random());

            Question question = Question(
                questionId: responseData[i]['questionId'],
                question: responseData[i]['questionText'],
                options: options,
                answer: responseData[i]['questionAnswer']);

            tempQuestions.add(question);
          }

          setQuestions(tempQuestions);

          // set total questions for xps
          _totalQuestions.value = tempQuestions.length;
          if (totalQuestions == 0) {
            setQuizError(true);
          }
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        setQuizError(true);
        debugPrint(
            "error getting quiz questions -------------------------------- getting quiz questions");
      } else {
        // Other errors like network issues
        setQuizError(true);
        debugPrint(
            "error getting quiz questions -------------------------------- getting quiz questions - connection");
      }
    } catch (e) {
      // Handle any exceptions
      setQuizError(true);
      debugPrint(
          "error getting quiz questions -------------------------------- getting quiz questions - error occured");
    }
  }

  // Get Quiz Questions
  Future<void> addQuizQuestions() async {
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.get(
          "${ApiUrl!}/TestQuestion?TestId=$quizId&Limit=$QuizQuestionNumber",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Set Questions
          var responseData = response.data;

          List<Question> tempQuestions = [];
          for (var i = 0; i < responseData.length; i++) {
            List<String> options =
                responseData[i]['questionOptions'].split('<=>');
            options.shuffle(Random());

            Question question = Question(
                questionId: responseData[i]['questionId'],
                question: responseData[i]['questionText'],
                options: options,
                answer: responseData[i]['questionAnswer']);

            tempQuestions.add(question);
          }

          // Add questions
          _questions.addAll(tempQuestions);
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        setQuizError(true);
        debugPrint(
            "error getting quiz questions -------------------------------- getting quiz questions");
      } else {
        // Other errors like network issues
        setQuizError(true);
        debugPrint(
            "error getting quiz questions -------------------------------- getting quiz questions - connection");
      }
    } catch (e) {
      // Handle any exceptions
      setQuizError(true);
      debugPrint(
          "error getting quiz questions -------------------------------- getting quiz questions - error occured");
    }
  }
}

// Sample biology quiz questions (Multiple Choice)
final List<Question> sampleQuestions = [
  const Question(
    questionId: 1,
    question: "Which of the following is the basic unit of life?",
    options: ["Cell", "Organ", "Tissue", "System"],
    answer: "Cell",
  ),
  const Question(
    questionId: 2,
    question:
        "What process uses sunlight, water, and carbon dioxide to produce glucose and oxygen?",
    options: ["Cellular respiration", "Photosynthesis", "Mitosis", "Meiosis"],
    answer: "Photosynthesis",
  ),
  const Question(
    questionId: 3,
    question: "What is the function of DNA?",
    options: [
      "To transport materials within the cell",
      "To store genetic information",
      "To provide energy for the cell",
      "To build proteins"
    ],
    answer: "To store genetic information",
  ),
  const Question(
    questionId: 4,
    question:
        "What is the process by which an organism inherits traits from its parents?",
    options: ["Adaptation", "Evolution", "Heredity", "Homeostasis"],
    answer: "Heredity",
  ),
  const Question(
    questionId: 5,
    question:
        "What are the structures in a plant cell that capture sunlight for photosynthesis?",
    options: ["Nucleus", "Chloroplasts", "Mitochondria", "Cell wall"],
    answer: "Chloroplasts",
  ),
];
