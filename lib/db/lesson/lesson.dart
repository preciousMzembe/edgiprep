import 'package:hive_flutter/hive_flutter.dart';

part 'lesson.g.dart';

@HiveType(typeId: 5)
class Lesson {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int order;

  @HiveField(3)
  final String topicId;

  @HiveField(4)
  final int numberOfSlides;

  @HiveField(5)
  final int numberOfSlidesDone;

  @HiveField(6)
  late bool active;

  @HiveField(7)
  late int lessonNumber;

  @HiveField(8)
  late bool isFirst;

  @HiveField(9)
  late bool isLast;

  Lesson({
    required this.id,
    required this.name,
    required this.order,
    required this.topicId,
    required this.numberOfSlides,
    required this.numberOfSlidesDone,
    this.active = false,
    this.lessonNumber = 0,
    this.isFirst = false,
    this.isLast = false,
  });

  toJson() => {
        'id': id,
        'name': name,
        'order': order,
        'topicId': topicId,
        'numberOfSlides': numberOfSlides,
        'numberOfSlidesDone': numberOfSlidesDone,
        'active': active,
        'lessonNumber': lessonNumber,
        'isFirst': isFirst,
        'isLast': isLast,
      };
}
