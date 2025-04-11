import 'package:dio/dio.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  AuthService authService = Get.find<AuthService>();
  UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();

  Config? config;
  final Dio _dio = createDio();

  // Initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    config = await configService.getConfig();
  }

  Future<Map> fetchData(Topic topic, Lesson lesson) async {
    bool error = true;
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        final response = await _dio.post(
          '${config?.apiUrl}/Slide/Mobile/Slides',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "subjectEnrollmentId": topic.subjectEnrollmentId,
            "lessonId": lesson.id,
          },
        );

        if (response.statusCode == 200) {
          var lessonData = response.data;

          return {
            'error': false,
            'lessonData': lessonData,
          };
        }
      } on DioException {
        error = true;
        debugPrint(
            "Error fetching lesson ------------------------- lesson service");
      }
    }

    // Return error true in case of failure
    return {'error': error};
  }

  Future<bool> saveSlideProgress(
      String subjectEnrollmentId, String slideId, String answerId) async {
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        var response = await _dio.post(
          '${config?.apiUrl}/Slide/Mobile/SlideProgress',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "subjectEnrollmentId": subjectEnrollmentId,
            "slideId": slideId,
            "answerId": answerId.isNotEmpty ? answerId : null,
          },
        );

        if (response.statusCode == 200) {
          userEnrollmentService.getUserServerSubjects();
          return false;
        }
      } on DioException {
        debugPrint(
            "Error saving slide progress ------------------------- lesson service");
      }
    }

    return true;
  }
}
