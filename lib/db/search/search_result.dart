import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'search_result.g.dart';

@HiveType(typeId: 17)
class SearchResult {
  @HiveField(0)
  final String type;

  @HiveField(1)
  late UserSubject? subject;

  @HiveField(2)
  late Topic? topic;

  SearchResult({required this.type, this.subject, this.topic});
}
