import 'package:hive_flutter/hive_flutter.dart';

part 'user_exam.g.dart';

@HiveType(typeId: 8)
class UserExam {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool selected;

  UserExam({required this.id, required this.title, required this.selected});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
