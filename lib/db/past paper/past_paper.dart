import 'package:hive_flutter/hive_flutter.dart';

part 'past_paper.g.dart';

@HiveType(typeId: 6)
class PastPaper {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String duration; // Duration in minutes

  @HiveField(3)
  final int questions; // List of question IDs or text

  @HiveField(4)
  final String subjectId;

  @HiveField(5)
  final double score;

  PastPaper({
    required this.id,
    required this.name,
    required this.duration,
    required this.questions,
    required this.subjectId,
    required this.score,
  });
}
