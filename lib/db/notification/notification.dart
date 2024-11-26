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
  final DateTime time;

  UserNotification(
      {required this.title, required this.message, required this.seen, required this.time});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'seen': seen,
      'time': time,
    };
  }
}
