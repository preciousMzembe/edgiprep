class Question {
  final int questionId;
  final String question;
  final List<String> options;
  final String answer;

  const Question({
    required this.questionId,
    required this.question,
    required this.options,
    required this.answer,
  });
}
