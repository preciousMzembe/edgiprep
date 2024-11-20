import 'package:hive_flutter/hive_flutter.dart';

part 'exam.g.dart';

@HiveType(typeId: 1)
class Exam {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  Exam({required this.id, required this.title});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
