import 'package:hive_flutter/hive_flutter.dart';

part 'topic.g.dart';

@HiveType(typeId: 4)
class Topic {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int order;

  @HiveField(3)
  final String unitId;

  @HiveField(4)
  final int numberOfLessons;

  @HiveField(5)
  final int numberOfLessonsDone;

  @HiveField(6)
  final bool needSubscrion;

  @HiveField(7)
  late bool active;

  @HiveField(8)
  final String subjectEnrollmentId;

  Topic({
    required this.id,
    required this.name,
    required this.order,
    required this.unitId,
    required this.numberOfLessons,
    required this.numberOfLessonsDone,
    required this.needSubscrion,
    this.active = false,
    required this.subjectEnrollmentId,
  });

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'unitId': unitId,
      'numberOfLessons': numberOfLessons,
      'numberOfLessonsDone': numberOfLessonsDone,
      'needSubscrion': needSubscrion,
      'active': active,
      'subjectEnrollmentId': subjectEnrollmentId,
    };
  }
}
