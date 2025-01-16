import 'package:hive_flutter/hive_flutter.dart';

part 'user_exam.g.dart';

@HiveType(typeId: 8)
class UserExam {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  late bool selected;

  @HiveField(3)
  late String enrollmentId;

  UserExam(
      {required this.id,
      required this.title,
      required this.selected,
      required this.enrollmentId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'selected': selected,
      'enrollmentId': enrollmentId,
    };
  }
}
