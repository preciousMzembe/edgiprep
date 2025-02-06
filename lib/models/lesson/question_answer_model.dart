class QuestionAnswerModel {
  final String id;
  final String text;
  final String? image;
  final String qusetionId;
  final bool isCorrect;

  QuestionAnswerModel({
    required this.id,
    required this.text,
    this.image,
    required this.qusetionId,
    required this.isCorrect,
  });
}
