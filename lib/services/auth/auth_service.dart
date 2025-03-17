// auth_service.dart
import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/user/user.dart';
import 'package:edgiprep/services/config/config_Service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  late Config? config;
  final Dio _dio = createDio();

  RxBool doneFetchingUserData = true.obs;
  RxBool doneLogin = true.obs;
  RxBool doneLogout = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    config = await configService.getConfig();

    getUserServerData();

    config ??= await configService.getConfig();
  }

  Future<void> getUserServerData() async {
    config ??= await configService.getConfig();

    // check if token is not empty first
    String? token = await getToken();

    if (token != null && token != '') {
      try {
        final response = await _dio.get(
          '${config?.apiUrl}/Learner/Mobile/Learner',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          User user = User(
            name: response.data['name'],
            email: "eagleeyed@gmail.com",
            xp: response.data['xp'],
            streak: response.data['streak'],
          );

          await userBox.clear();
          await userBox.add(user);
        }
      } on DioException catch (e) {
        debugPrint("Error fetching learner data ------------ auth service");

        if (e.response != null) {
          if (e.response?.statusCode == 401) {
            await logout();
          }
        }
      }
    }

    doneFetchingUserData.value = !doneFetchingUserData.value;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('${config?.apiUrl}/Auth/Mobile/Login',
          data: {'username': email, 'pin': password});

      if (response.statusCode == 200) {
        _saveToken(response.data['token']);

        await getUserServerData();

        doneLogin.value = !doneLogin.value;

        return {
          'status': "success",
          'data': response.data['token'],
        };
      }
    } on DioException catch (e) {
      debugPrint("Error loggin in ------------ auth service");
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          return {
            'status': "error",
            'error': e.response?.data['message'],
          };
        }
      }
    }

    return {
      'status': "error",
      'error': "Error logging in",
    };
  }

  Future<Map<String, dynamic>> register(
      String name, String username, String password) async {
    try {
      final response = await _dio.post('${config?.apiUrl}/Auth/Mobile/Register',
          data: {'name': username, 'username': username, 'pin': password});

      if (response.statusCode == 200) {
        _saveToken(response.data['token']);

        await getUserServerData();

        return {
          'status': "success",
          'data': response.data['token'],
        };
      }
    } on DioException catch (e) {
      debugPrint("Error registering ------------ auth service");

      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          return {
            'status': "error",
            'error': e.response?.data['message'],
          };
        }
      }
    }

    return {
      'status': "error",
      'error': "Error logging in",
    };
  }

  Future<Map<String, dynamic>> checkUsername(String username) async {
    try {
      final response = await _dio
          .get('${config?.apiUrl}/Auth/Mobile/Username?username=$username');

      if (response.statusCode == 200) {
        return {
          'status': "success",
          'data': 'Username is available',
        };
      }
    } on DioException catch (e) {
      debugPrint("Error checking username ------------ auth service");

      if (e.response != null) {
        if (e.response?.statusCode == 409) {
          return {
            'status': "error",
            'error': 'Username is already taken',
          };
        }
      }
    }

    return {
      'status': "error",
      'error': "Error checking username",
    };
  }

  Future<void> logout() async {
    await _removeToken();
    await userExamBox.clear();

    doneLogout.value = !doneLogout.value;
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
