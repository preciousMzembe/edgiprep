class LessonSlideQuestionModel {
  final String questionText;
  final List<String> options;
  final String explanation;
  final String correctAnswer;
  String userAnswer;

  LessonSlideQuestionModel({
    required this.questionText,
    required this.options,
    required this.explanation,
    required this.correctAnswer,
    this.userAnswer = "",
  });

  // Method to set the user's answer
  void setUserAnswer(String answer) {
    userAnswer = answer;
  }
}
