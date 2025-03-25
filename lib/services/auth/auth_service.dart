// auth_service.dart
import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/user/user.dart';
import 'package:edgiprep/services/config/config_Service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ConfigService configService = Get.find<ConfigService>();
  late Config? config;
  final Dio _dio = createDio();

  final String _tokenKey = "authToken";

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
        debugPrint("Problem fetching learner data ------------ auth service");

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
      debugPrint("Problem loggin in ------------ auth service");
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          return {
            'status': "error",
            'error': "Incorrect Username or Pin.",
          };
        }
      }
    }

    return {
      'status': "error",
      'error': "There was a problem logging in.",
    };
  }

  Future<Map<String, dynamic>> register(
      String name, String username, String password) async {
    try {
      final response = await _dio.post('${config?.apiUrl}/Auth/Mobile/Register',
          data: {'name': name, 'username': username, 'pin': password});

      if (response.statusCode == 200) {
        _saveToken(response.data['token']);

        await getUserServerData();

        return {
          'status': "success",
          'data': response.data['token'],
        };
      }
    } on DioException catch (e) {
      debugPrint("Problem registering ------------ auth service");

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
      'error': "There was a problem creating account.",
    };
  }

  Future<Map<String, dynamic>> checkUsername(String username) async {
    try {
      final response = await _dio
          .get('${config?.apiUrl}/Auth/Mobile/Username?username=$username');

      if (response.statusCode == 200) {
        return {
          'status': "success",
          'data': 'Username is available.',
        };
      }
    } on DioException catch (e) {
      debugPrint("Problem checking username ------------ auth service");

      if (e.response != null) {
        if (e.response?.statusCode == 409) {
          return {
            'status': "error",
            'error': 'Username is already taken.',
          };
        }
      }
    }

    return {
      'status': "error",
      'error': "Problem checking username.",
    };
  }

  Future<void> logout() async {
    await _removeToken();
    await userExamBox.clear();

    doneLogout.value = !doneLogout.value;
  }

  // Profile Settings
  Future<Map<String, dynamic>> changeName(String name) async {
    try {
      String? token = await getToken();

      final response = await _dio.put(
        '${config?.apiUrl}/Account/Mobile/Name',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        return {
          'status': "success",
          'data': 'Name changed successfully',
        };
      }
    } on DioException {
      debugPrint("Problem changing name ------------ auth service");
    }

    return {
      'status': "error",
      'error': "There was a problem changing your name.",
    };
  }

  Future<Map<String, dynamic>> changeUsername(String username) async {
    try {
      String? token = await getToken();

      var checkData = await checkUsername(username);

      if (checkData['status'] == 'error') return checkData;

      final response = await _dio.put(
        '${config?.apiUrl}/Account/Mobile/Username',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        return {
          'status': "success",
          'data': 'Username changed successfully',
        };
      }
    } on DioException {
      debugPrint("Problem changing username ------------ auth service");
    }

    return {
      'status': "error",
      'error': "there was a problem changing your username.",
    };
  }

  Future<Map<String, dynamic>> changePassword(String password) async {
    try {
      String? token = await getToken();

      final response = await _dio.put(
        '${config?.apiUrl}/Account/Mobile/Password',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return {
          'status': "success",
          'data': 'Pin changed successfully',
        };
      }
    } on DioException {
      debugPrint("Problem changing pin ------------ auth service");
    }

    return {
      'status': "error",
      'error': "There was a problem changing your pin.",
    };
  }

  Future<Map<String, dynamic>> changeEmail(String email) async {
    try {
      String? token = await getToken();

      final response = await _dio.put(
        '${config?.apiUrl}/Account/Mobile/Email',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return {
          'status': "success",
          'data': 'Email changed successfully',
        };
      }
    } on DioException {
      debugPrint("Problem changing email ------------ auth service");
    }

    return {
      'status': "error",
      'error': "There was a problem changing your email.",
    };
  }

  Future<Map<String, dynamic>> changePhone(String phone) async {
    try {
      String? token = await getToken();

      final response = await _dio.put(
        '${config?.apiUrl}/Account/Mobile/Phone',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        return {
          'status': "success",
          'data': 'Email changed successfully',
        };
      }
    } on DioException {
      debugPrint("Problem changing phone ------------ auth service");
    }

    return {
      'status': "error",
      'error': "There was a problem changing your phone number.",
    };
  }

  // Token handling
  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> _removeToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<bool> isLoggedIn() async {
    String? token = await getToken();
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
