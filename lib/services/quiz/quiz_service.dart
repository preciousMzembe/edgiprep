import 'package:dio/dio.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  AuthService authService = Get.find<AuthService>();

  Config? config;
  final Dio _dio = createDio();

  // Initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    config = await configService.getConfig();
  }

  Future<Map> fetchData(String subjectEnrollmentId, int limit) async {
    bool error = false;
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        final response = await _dio.post(
          '${config?.apiUrl}/Quiz/Mobile/Quiz',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "subjectEnrollmentId": subjectEnrollmentId,
            "limit": limit,
          },
        );

        if (response.statusCode == 200) {
          Map quizData = response.data;

          return {
            'error': error,
            'quizData': quizData,
          };
        }
      } on DioException {
        error = true;
        debugPrint(
            "Error fetching quiz ------------------------- quiz service");
      }
    }

    // Return error true in case of failure
    return {'error': error};
  }

  Future<void> saveQuestionScore(
      String subjectEnrollmentId, String quizId, String answerId) async {
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        await _dio.put(
          '${config?.apiUrl}/Quiz/Mobile/QuizQuestionProgress',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "subjectEnrollmentId": subjectEnrollmentId,
            "quizId": quizId,
            "answerId": answerId,
          },
        );
      } on DioException {
        debugPrint(
            "Error saving question score ------------------------- quiz service");
      }
    }
  }

  Future<void> saveQuizScore(String quizId, int score) async {
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        await _dio.put(
          '${config?.apiUrl}/Quiz/Mobile/QuizScore',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "quizId": quizId,
            "score": score,
          },
        );
      } on DioException {
        debugPrint(
            "Error saving quiz score ------------------------- quiz service");
      }
    }
  }
}
