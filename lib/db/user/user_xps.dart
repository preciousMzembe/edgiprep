import 'package:hive_flutter/hive_flutter.dart';

part 'user_xps.g.dart';

@HiveType(typeId: 14)
class UserXps {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int xps;

  UserXps({
    required this.id,
    required this.xps,
  });
}
