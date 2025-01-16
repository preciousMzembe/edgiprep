// auth_controller.dart
import 'package:edgiprep/db/user/user.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  RxBool isLoading = false.obs;
  Rx<User?> user = Rx<User?>(null);

  RxString authToken = "".obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();

    // listen to change in user exams fetch
    ever(authService.doneFetchingUserData, (_) async {
      checkLoginStatus();
    });
  }

  // Check login status
  void checkLoginStatus() async {
    String? tocket = await authService.getToken();

    if (tocket != null && tocket != "") {
      await getUserData();
      authToken.value = tocket;

      authToken.refresh();
      user.refresh();
    } else {
      authToken.value = "";
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading.value = true;
    final loginData = await authService.login(email, password);

    if (loginData['status'] == 'success') {
      checkLoginStatus();
    }

    isLoading.value = false;
    return loginData;
  }

  Future<Map<String, dynamic>> register(
      String name, String username, String password) async {
    isLoading.value = true;

    // check username
    Map<String, dynamic> checkUsernameData = await checkUsername(username);

    if (checkUsernameData['status'] == 'error') {
      isLoading.value = false;
      return checkUsernameData;
    }

    final registerData = await authService.register(name, username, password);
    if (registerData['status'] == 'success') {
      checkLoginStatus();
    }

    isLoading.value = false;
    return registerData;
  }

  Future<Map<String, dynamic>> checkUsername(String username) async {
    final checkingData = await authService.checkUsername(username);

    return checkingData;
  }

  Future<void> logout() async {
    await authService.logout();
    checkLoginStatus();
  }

  Future<void> getUserData() async {
    User? localUser = await authService.getUserData();

    if (localUser != null) {
      user.value = localUser;
    }
  }
}
