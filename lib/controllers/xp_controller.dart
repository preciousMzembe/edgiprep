import 'package:dio/dio.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XPController extends GetxController {
  UserController userController = Get.find<UserController>();
  final secureStorage = SecureStorageService();
  final Dio dio = Dio();

  final RxInt xps = 0.obs;

  Future<void> addXP(int xp) async {
    xps.value = xps.value + xp;
  }

  Future<void> incrementUserXps(int xp) async {
    userController.xps.value = userController.xps.value + xp;
  }

  // Save XPs
  Future<void> saveXP(int xp) async {
    String? key = await secureStorage.readKey("userKey");

    if (key != null && key.isNotEmpty) {
      // add xps
      if (xp > 0) {
        await addXP(xp);
        await incrementUserXps(xp);

        await secureStorage.writeKey("userXPs", xps.value.toString());

        // attempt save
        try {
          final Map<String, dynamic> headers = {
            'AuthKey': key,
            'Content-Type': 'application/json',
          };
          final response = await dio.put(
            "${ApiUrl!}/LearnerProfile/UpdateXp?xpToAdd=$xp",
            options: Options(
              headers: headers,
            ),
          );

          if (response.statusCode == 200) {
            // delete local
            await secureStorage.writeKey("userXPs", "0");
          }
        } on DioException catch (e) {
          if (e.response != null) {
            debugPrint(
                "error saving xps -------------------------------- saving xps");
          } else {
            // Other errors like network issues
            debugPrint(
                "error saving xps -------------------------------- saving xps - connection");
          }
        } catch (e) {
          // Handle any exceptions
          debugPrint(
              "error saving xps -------------------------------- saving xps - error occured");
        }
      }
    }
  }

  // Save from local to DB at the start
  Future<void> saveFromLocal() async {
    String? key = await secureStorage.readKey("userKey");
    String? userXPs = await secureStorage.readKey("userXPs");

    if (key != null && key.isNotEmpty && userXPs != null && userXPs != "0") {
      // save
      try {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.put(
          "${ApiUrl!}/LearnerProfile/UpdateXp?xpToAdd=$userXPs",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // delete local
          await incrementUserXps(int.parse(userXPs));
          await secureStorage.writeKey("userXPs", "0");
        }
      } on DioException catch (e) {
        if (e.response != null) {
          debugPrint(
              "error saving xps -------------------------------- saving xps init");
        } else {
          // Other errors like network issues
          // increment user xps
          await addXP(int.parse(userXPs));
          await incrementUserXps(int.parse(userXPs));
          debugPrint(
              "error saving xps -------------------------------- saving xps - connection init");
        }
      } catch (e) {
        // Handle any exceptions
        debugPrint(
            "error saving xps -------------------------------- saving xps - error occured init");
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();

    await saveFromLocal();
  }
}
