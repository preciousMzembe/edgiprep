import 'package:hive_flutter/hive_flutter.dart';

part 'user_subject.g.dart';

@HiveType(typeId: 9)
class UserSubject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String color;

  @HiveField(4)
  final String icon;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final String examId;

  @HiveField(7)
  final int numberOfTopics;

  @HiveField(8)
  final int numberOfTopicsDone;

  @HiveField(9)
  final String currentTopic;

  UserSubject({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.image,
    required this.examId,
    required this.numberOfTopics,
    required this.numberOfTopicsDone,
    required this.currentTopic,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'icon': icon,
      'image': image,
      'examId': examId,
      'currentTopic': currentTopic,
    };
  }
}
