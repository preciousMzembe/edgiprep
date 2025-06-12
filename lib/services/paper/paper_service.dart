import 'package:dio/dio.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaperService extends GetxService {
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

  Future<Map> fetchData(String testId) async {
    bool error = true;
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        final response = await _dio.get(
          '${config?.apiUrl}/Test/Mobile/GetLearnerTest?TestId=$testId',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          Map paperData = response.data;

          return {
            'error': false,
            'paperData': paperData,
          };
        }
      } on DioException {
        error = true;
        debugPrint(
            "Error fetching paper ------------------------- paper service");
      }
    }

    // Return error true in case of failure
    return {'error': error};
  }

  Future<void> saveTestScore(
      String testDoneId, double score, List<String> answerIds) async {
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        await _dio.put(
          '${config?.apiUrl}/Test/Mobile/UpdateTestScore',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "testDoneId": testDoneId,
            "score": score,
            "answerIds": answerIds,
          },
        );
      } on DioException {
        debugPrint(
            "Error saving test score ------------------------- paper service");
      }
    }
  }
}
