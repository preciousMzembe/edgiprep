import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final int xp;

  @HiveField(3)
  final int streak;

  @HiveField(4)
  final DateTime reminderTime;

  @HiveField(5)
  final double weeklyProgress;

  User({
    required this.name,
    required this.email,
    required this.xp,
    required this.streak,
    required this.reminderTime,
    required this.weeklyProgress,
  });
}
