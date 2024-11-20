// auth_service.dart
import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/user/user.dart';
import 'package:edgiprep/services/config/config_Service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  late Config? config;
  final Dio _dio = createDio();

  RxBool doneFetchingUserData = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    config = await configService.getConfig();

    getUserServerData();

    config ??= await configService.getConfig();
  }

  Future<void> getUserServerData() async {
    // TODO: check if tocken is not empty first
    User user = User(
      name: "Levon James",
      email: "eagleeyed@gmail.com",
      xp: 20,
      streak: 10,
      reminderTime: DateTime(2021, 1, 2, 2),
      weeklyProgress: 30,
    );

    await userBox.clear();
    await userBox.add(user);

    doneFetchingUserData.value = !doneFetchingUserData.value;
  }

  Future<User?> login(String email, String password) async {
    // _saveToken(response.body['token']);
    return null;
  }

  Future<User?> register(String name, String email, String password) async {
    // _saveToken(response.body['token']);
    return null;
  }

  Future<void> logout() async {
    await _removeToken();
    await userExamBox.clear();
  }

  // Token handling
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<User?> getUserData() async {
    if (userBox.isNotEmpty) {
      User userData = await userBox.values.first;
      return userData;
    }

    return null;
  }
}
