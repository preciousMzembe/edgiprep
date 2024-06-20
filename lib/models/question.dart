class Question {
  final int question_id;
  final String question;
  final List<String> options;
  final String answer;

  const Question({
    required this.question_id,
    required this.question,
    required this.options,
    required this.answer,
  });
}
