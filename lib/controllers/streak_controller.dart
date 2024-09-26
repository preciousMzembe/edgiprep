import 'package:dio/dio.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StreakController extends GetxController {
  final secureStorage = SecureStorageService();
  final Dio dio = Dio();

  // Save Streak
  Future<void> saveStreak() async {
    String? key = await secureStorage.readKey("userKey");

    if (key != null && key.isNotEmpty) {
      // save streak
      try {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        await dio.post(
          "${ApiUrl!}/Streak/AddStreak",
          options: Options(
            headers: headers,
          ),
        );

        getUserDetails();
      } on DioException catch (e) {
        if (e.response != null) {
          debugPrint(
              "error saving streak -------------------------------- saving streak");
        } else {
          // Other errors like network issues
          debugPrint(
              "error saving streak -------------------------------- saving streak - connection");
        }
      } catch (e) {
        // Handle any exceptions
        debugPrint(
            "error saving streak -------------------------------- saving streak - error occured");
      }
    }
  }
}
