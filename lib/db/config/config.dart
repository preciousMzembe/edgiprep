import 'package:hive_flutter/hive_flutter.dart';

part 'config.g.dart';

@HiveType(
    typeId: 7) // Ensure this typeId is unique across all your Hive classes
class Config {
  @HiveField(0)
  final String apiUrl;

  @HiveField(1)
  final String imagesUrl;

  @HiveField(2)
  final String privacyPolicyUrl;

  @HiveField(3)
  final String appUrl;

  @HiveField(4)
  final int quizQuestions;

  Config({
    required this.apiUrl,
    required this.imagesUrl,
    required this.privacyPolicyUrl,
    required this.appUrl,
    required this.quizQuestions,
  });

  Map<String, dynamic> toJson() {
    return {
      'apiUrl': apiUrl,
      'imagesUrl': imagesUrl,
      'privacyPolicyUrl': privacyPolicyUrl,
      'appUrl': appUrl,
      'quizQuestions': quizQuestions,
    };
  }
}
