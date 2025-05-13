import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/user/user_xps.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  AuthService authService = Get.find<AuthService>();

  Config? config;
  final Dio _dio = createDio();

  // Initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    config = await configService.getConfig();

    // Atempt Xps saving
    UserXps localXps = userXpsBox.get(0) ?? UserXps(id: 0, xps: 0);
    if (localXps.xps > 0) {
      await saveXps(0);
    }
  }

  Future<void> saveXps(int xps) async {
    UserXps localXps = userXpsBox.values.isNotEmpty
        ? userXpsBox.values.first
        : UserXps(id: 0, xps: 0);

    int newXps = localXps.xps + xps;

    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        final response = await _dio.put(
          '${config?.apiUrl}/Learner/Mobile/UpdateXP',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "xp": newXps,
          },
        );

        if (response.statusCode != 200) {
          // save xps to local storage
          await userXpsBox.clear();

          UserXps userXps = UserXps(
            id: 0,
            xps: newXps,
          );

          userXpsBox.add(userXps);
          authService.updateXps(xps);
        } else {
          await userXpsBox.clear();
          authService.updateXps(xps);
          authService.getUserServerData();
        }
      } on DioException {
        debugPrint(
            "Error updating xps ------------------------- stats service");
      }
    }
  }

  // Save Streak
  Future<void> saveStreak() async {
    config ??= await configService.getConfig();

    // Check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        final response = await _dio.post(
          '${config?.apiUrl}/Learner/Mobile/AddStreak',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 204) {
          authService.getUserServerData();
        }
      } on DioException {
        debugPrint(
            "Error updating streak ------------------------- stats service");
      }
    }
  }
}
