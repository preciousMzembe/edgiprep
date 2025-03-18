import 'package:edgiprep/models/lesson/question_answer_model.dart';

class LessonSlideQuestionModel {
  final String id;
  final String questionText;
  final String? questionImage;
  List<QuestionAnswerModel> options;
  final String explanation;
  final String? explanationImage;
  String correctAnswerId;
  String userAnswerId;

  LessonSlideQuestionModel({
    required this.id,
    required this.questionText,
    required this.questionImage,
    required this.options,
    required this.explanation,
    required this.explanationImage,
    this.correctAnswerId = "",
    this.userAnswerId = "",
  });

  // Method to set the user's answer
  void setCorrectUserAnswer(String answerId) {
    correctAnswerId = answerId;
  }

  void setUserAnswer(String answerId) {
    userAnswerId = answerId;
  }

  void setOptions(List<QuestionAnswerModel> newOptions) {
    options = newOptions;
  }

  toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'questionImage': questionImage,
      'options': options,
      'explanation': explanation,
      'explanationImage': explanationImage,
      'correctAnswerId': correctAnswerId,
      'userAnswerId': userAnswerId,
    };
  }
}
