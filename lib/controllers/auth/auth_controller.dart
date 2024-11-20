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
    // String? tocket = await authService.getToken();
    String? tocket = "12345";

    if (tocket != null) {
      await getUserData();
      authToken.value = tocket;

      authToken.refresh();
      user.refresh();
    } else {
      authToken.value = "";
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final loggedInUser = await authService.login(email, password);
      if (loggedInUser != null) {
        checkLoginStatus();
      }
    } catch (e) {
      debugPrint("Error logging in ----------------- auth controller");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;
      final registeredUser = await authService.register(name, email, password);
      if (registeredUser != null) {
        checkLoginStatus();
      }
    } catch (e) {
      debugPrint("Error registering user -------------- auth controller");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await authService.logout();
    checkLoginStatus();
  }

  Future<void> getUserData() async {
    User? localUser = await authService.getUserData();

    if (localUser != null) {
      user.value = localUser;
    } else {
      logout();
    }
  }
}
