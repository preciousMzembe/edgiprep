import 'package:dio/dio.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  AuthService authService = Get.find<AuthService>();

  RxBool isEnd = false.obs;

  Config? config;
  final Dio _dio = createDio();

  // Initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    config = await configService.getConfig();
  }

  Future<Map> fetchData(String subjectEnrollmentId) async {
    isEnd.value = false;

    bool error = false;
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        final response = await _dio.post(
          '${config?.apiUrl}/Quiz/Mobile/ChallengeQuiz',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "subjectEnrollmentId": subjectEnrollmentId,
          },
        );

        if (response.statusCode == 200) {
          Map quizData = response.data;

          if (quizData['isEnd']) {
            isEnd.value = true;
          }

          return {
            'error': error,
            'quizData': quizData,
          };
        }
      } on DioException {
        error = true;
        debugPrint(
            "Error fetching challenge ------------------------- challenge service");
      }
    }

    // Return error true in case of failure
    return {'error': error};
  }

  Future<Map> fetchNewData(String subjectEnrollmentId, String quizId) async {
    bool error = false;
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (!isEnd.value) {
      if (token != null && token.isNotEmpty) {
        try {
          final response = await _dio.post(
            '${config?.apiUrl}/Quiz/Mobile/ChallengeQuiz',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
            data: {
              "subjectEnrollmentId": subjectEnrollmentId,
              "quizId": quizId,
            },
          );

          if (response.statusCode == 200) {
            Map quizData = response.data;

            if (quizData['isEnd']) {
              isEnd.value = true;
            }

            return {
              'error': false,
              'quizData': quizData,
            };
          }
        } on DioException {
          error = true;
          debugPrint(
              "Error fetching new challenge questions ------------------------- challenge service");
        }
      }
    } else {
      error = true;
    }

    // Return error true in case of failure
    return {'error': error};
  }

  Future<void> saveQuestionScores(
      String subjectEnrollmentId, String quizId, List<String> answerIds) async {
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
            "answerIds": answerIds,
            "type": 2,
          },
        );
      } on DioException {
        debugPrint(
            "Error saving challenge score ------------------------- challenge service");
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
            "Error saving challenge score ------------------------- challenge service");
      }
    }
  }
}
