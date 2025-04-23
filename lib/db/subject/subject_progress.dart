import 'package:hive_flutter/hive_flutter.dart';

part 'subject_progress.g.dart';

@HiveType(typeId: 12)
class SubjectProgress {
  @HiveField(0)
  final String subjectEnrollmentId;

  @HiveField(1)
  final int completedLessons;

  @HiveField(2)
  final int totalLessons;

  @HiveField(3)
  final int totalTopics;

  @HiveField(4)
  final int coveredTopics;

  @HiveField(5)
  final int completedQuizzes;

  @HiveField(6)
  final int completedMocks;

  @HiveField(7)
  final int completedPPs;

  SubjectProgress({
    required this.subjectEnrollmentId,
    required this.completedLessons,
    required this.totalLessons,
    required this.totalTopics,
    required this.coveredTopics,
    required this.completedQuizzes,
    required this.completedMocks,
    required this.completedPPs,
  });

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectEnrollmentId,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'totalTopics': totalTopics,
      'coveredTopics': coveredTopics,
      'completedQuizzes': completedQuizzes,
      'completedMocks': completedMocks,
      'completedPPs': completedPPs,
    };
  }
}
