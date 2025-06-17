import 'package:hive_flutter/hive_flutter.dart';

part 'config.g.dart';

@HiveType(
    typeId: 7) // Ensure this typeId is unique across all your Hive classes
class Config {
  @HiveField(0)
  final String apiUrl;

  @HiveField(1)
  final String privacyPolicyUrl;

  @HiveField(2)
  final String appUrl;

  @HiveField(3)
  final int quizQuestions;

  @HiveField(4)
  final int topicQuizQuestions;

  @HiveField(5)
  final String premiumPrice;

  @HiveField(6)
  final String subjectsImageUrl;

  Config({
    required this.apiUrl,
    required this.privacyPolicyUrl,
    required this.appUrl,
    required this.quizQuestions,
    required this.topicQuizQuestions,
    required this.premiumPrice,
    required this.subjectsImageUrl,
  });

  Map<String, Object> toJson() {
    return {
      'apiUrl': apiUrl,
      'privacyPolicyUrl': privacyPolicyUrl,
      'appUrl': appUrl,
      'quizQuestions': quizQuestions,
      'topicQuizQuestions': topicQuizQuestions,
      'premiumPrice': premiumPrice,
      'subjectsImageUrl': subjectsImageUrl,
    };
  }
}
