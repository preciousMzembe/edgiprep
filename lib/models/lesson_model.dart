class LessonModel {
  final int lessonId;
  final String lessonName;
  final int slidesNumber;
  final int slidesDone;
  final bool currentLesson;
  final bool finalLesson;
  final bool lessonDone;

  const LessonModel({
    required this.lessonId,
    required this.lessonName,
    required this.slidesNumber,
    required this.slidesDone,
    required this.currentLesson,
    required this.finalLesson,
    required this.lessonDone,
  });

  Map<String, dynamic> get toMap {
    return {
      'lessonId': lessonId,
      'lessonName': lessonName,
      'slidesNumber': slidesNumber,
      'slidesDone': slidesDone,
      'currentLesson': currentLesson,
      'finalLesson': finalLesson,
      'lessonDone': lessonDone,
    };
  }
}
