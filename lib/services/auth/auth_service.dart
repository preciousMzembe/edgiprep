// auth_service.dart
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/user/user.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
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
          double weekly = 0;
          int streak = 0;

          final stats = await _dio.get(
            '${config?.apiUrl}/Learner/Mobile/MyStats',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          );

          if (stats.statusCode == 200) {
            weekly = (stats.data['weekly'] as num?)?.toDouble() ?? 0.0;
            streak = stats.data['streaks'] ?? 0;
          }

          int randomNumber = DateTime.now().millisecondsSinceEpoch;

          bool isArchived = response.data['isArchived'] ?? false;

          if (isArchived) {
            await userBox.clear();
            await logout();
            return;
          }

          User user = User(
            name: response.data['name'],
            username: response.data['userName'],
            profileImage: "${response.data['profileImage']}?$randomNumber",
            email: response.data['email'],
            xp: response.data['xp'],
            streak: streak,
            weekly: weekly,
            localXp: 0,
          );

          await userBox.clear();
          await userBox.add(user);
        }
      } on DioException catch (e) {
        debugPrint("Problem fetching learner data ------------ auth service");

        if (e.response != null) {
          if (e.response?.statusCode == 404) {
            await logout();
          }
        }
      }
    }

    doneFetchingUserData.value = !doneFetchingUserData.value;
  }

  Future<void> updateXps(int xps) async {
    // update local xps
    User? user = await getUserData();
    if (user != null) {
      User updatedUser = User(
        name: user.name,
        username: user.username,
        profileImage: user.profileImage,
        email: user.email,
        xp: user.xp,
        streak: user.streak,
        weekly: user.weekly,
        localXp: user.localXp + xps,
      );

      await userBox.putAt(0, updatedUser);

      getUserServerData();
    }
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

    await userBox.clear();
    await userExamBox.clear();
    await userSubjectBox.clear();
    await unitBox.clear();
    await topicBox.clear();
    await lessonBox.clear();
    await pastPaperBox.clear();
    await mockExamBox.clear();
    await searchResultsBox.clear();

    doneLogout.value = !doneLogout.value;
  }

  // Profile Settings
  Future<Map<String, dynamic>> changeName(String name) async {
    try {
      String? token = await getToken();

      final response = await _dio.put(
        '${config?.apiUrl}/Learner/Mobile/UpdateName',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'value': name,
        },
      );

      if (response.statusCode == 200) {
        await getUserServerData();
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
        '${config?.apiUrl}/Learner/Mobile/UpdateUsername',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'value': username,
        },
      );

      if (response.statusCode == 204) {
        await getUserServerData();
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
      'error': "There was a problem changing your username.",
    };
  }

  Future<Map<String, dynamic>> changePassword(
      String password, String newPassword) async {
    try {
      String? token = await getToken();

      final response = await _dio.put(
        '${config?.apiUrl}/Learner/Mobile/UpdatePIN',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'pin': password,
          'newPin': newPassword,
        },
      );

      if (response.statusCode == 204) {
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
      'error': "Check your current pin if correct.",
    };
  }

  Future<Map<String, dynamic>> changeEmail(String email) async {
    try {
      String? token = await getToken();

      final response = await _dio.put(
        '${config?.apiUrl}/Learner/Mobile/UpdateEmail',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'value': email,
        },
      );

      if (response.statusCode == 204) {
        await getUserServerData();
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

  // Upload Profile Picture
  Future<Map<String, dynamic>> uploadProfilePicture(String filePath) async {
    try {
      String? token = await getToken();

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(filePath),
      });

      final response = await _dio.put(
        '${config?.apiUrl}/Learner/Mobile/UploadProfilePicture',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        await getUserServerData();
        return {
          'status': "success",
          'data': 'Profile picture updated successfully',
        };
      }
    } on DioException {
      debugPrint("Problem uploading profile picture ------------ auth service");
    }

    return {
      'status': "error",
      'error': "There was a problem uploading your profile picture.",
    };
  }

  // Delete Account
  Future<Map<String, dynamic>> deleteAccount(String password) async {
    try {
      String? token = await getToken();

      final response = await _dio.delete(
        '${config?.apiUrl}/Learner/Mobile/DeleteMyAccount?PIN=$password',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 204) {
        logout();

        return {
          'status': "success",
          'data': 'Account deleted successfully.',
        };
      }
    } on DioException catch (e) {
      // print code snippet
      var data = e.response?.data;
      if (data != null && data['message'] != null) {
        if (data['message'] == "Incorrect PIN") {
          return {
            'status': "error",
            'error': "You entered an incorrect PIN.",
          };
        }
      }
      debugPrint("Problem deleting account ------------ auth service");
    }

    return {
      'status': "error",
      'error': "There was a problem deleting your account.",
    };
  }

  // Check if App is Locked
  Future<bool> checkAppLocked() async {
    String? token = await getToken();
    if (token == null) return false;

    final response = await _dio.get(
      '${config?.apiUrl}/Config/IsMobileActive',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return !response.data['isActive'];
    }

    return false;
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
