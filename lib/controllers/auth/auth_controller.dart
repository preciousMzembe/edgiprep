// auth_controller.dart
import 'package:edgiprep/db/user/user.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
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
    String? token = await authService.getToken();

    if (token != null && token != "") {
      await getUserData();
      authToken.value = token;

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

  // Profile Settings
  Future<Map<String, dynamic>> changeName(String name) async {
    return await authService.changeName(name);
  }

  Future<Map<String, dynamic>> changeUsername(String username) async {
    return await authService.changeUsername(username);
  }

  Future<Map<String, dynamic>> changePassword(String pin, String newPin) async {
    return await authService.changePassword(pin, newPin);
  }

  Future<Map<String, dynamic>> changeEmail(String email) async {
    if (!isValidEmail(email)) {
      return {
        "status": "error",
        "error": "Please enter a valid email address",
      };
    }
    return await authService.changeEmail(email);
  }

  Future<Map<String, dynamic>> changePhone(String phone) async {
    return await authService.changePhone(phone);
  }

  // Delete Account
  Future<Map<String, dynamic>> deleteAccount(String password) async {
    return await authService.deleteAccount(password);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }
}
