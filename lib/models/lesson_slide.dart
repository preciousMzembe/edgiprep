class LessonSlide {
  final int lessonId;
  final String? content;
  final LessonQuestion? question;

  LessonSlide({required this.lessonId, this.content, this.question});
}

class LessonQuestion {
  final String question;
  final List<String> options;
  final String answer;
  String userAnswer = "";

  LessonQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });
}
