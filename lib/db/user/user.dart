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

  User({
    required this.name,
    required this.email,
    required this.xp,
    required this.streak,
  });
}
