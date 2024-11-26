import 'package:hive_flutter/hive_flutter.dart';

part 'reminder.g.dart';

@HiveType(typeId: 10)
class Reminder {
  @HiveField(0)
  final String time;

  @HiveField(1)
  late bool set;

  Reminder({required this.time, required this.set});

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'set': set,
    };
  }
}
