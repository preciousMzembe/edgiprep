import 'package:hive_flutter/hive_flutter.dart';

part 'subject.g.dart';

@HiveType(typeId: 2)
class Subject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;
  @HiveField(2)
  final String icon;

  @HiveField(3)
  final String examId;

  Subject({
    required this.id,
    required this.title,
    required this.icon,
    required this.examId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'examId': examId,
    };
  }
}
