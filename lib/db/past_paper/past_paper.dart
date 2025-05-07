import 'package:hive_flutter/hive_flutter.dart';

part 'past_paper.g.dart';

@HiveType(typeId: 6)
class PastPaper {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int questions;

  @HiveField(3)
  final String subjectId;

  @HiveField(4)
  final int duration;

  PastPaper({
    required this.id,
    required this.name,
    required this.questions,
    required this.subjectId,
    required this.duration,
  });
}
