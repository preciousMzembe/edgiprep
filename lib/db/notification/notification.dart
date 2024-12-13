import 'package:hive_flutter/hive_flutter.dart';

part 'notification.g.dart';

@HiveType(typeId: 11)
class UserNotification {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String message;

  @HiveField(2)
  late bool seen;

  @HiveField(3)
  final String date;

  @HiveField(4)
  final String time;

  UserNotification({
    required this.title,
    required this.message,
    required this.seen,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'seen': seen,
      'timDdatee': date,
      'time': time,
    };
  }
}
