class LessonModel {
  final int lessonId;
  final String lessonName;

  const LessonModel({
    required this.lessonId,
    required this.lessonName,
  });

  Map<String, dynamic> get toMap {
    return {
      'lessonId': lessonId,
      'lessonName': lessonName,
    };
  }
}
