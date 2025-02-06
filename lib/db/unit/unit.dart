import 'package:hive_flutter/hive_flutter.dart';

part 'unit.g.dart';

@HiveType(typeId: 3)
class Unit {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int order;

  @HiveField(3)
  final String subjectEnrollmentId;

  Unit({
    required this.id,
    required this.name,
    required this.order,
    required this.subjectEnrollmentId,
  });
}
