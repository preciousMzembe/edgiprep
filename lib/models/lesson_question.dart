class LessonQuestion {
  final int questionId;
  final String question;
  final List<String> options;
  final String answer;
  String userAnswer = "";
  final String lessonContent;

  LessonQuestion({
    required this.questionId,
    required this.question,
    required this.options,
    required this.answer,
    required this.userAnswer,
    required this.lessonContent,
  });
}
