import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class SettingsController extends GetxController {
  final secureStorage = SecureStorageService();
  final Dio dio = Dio();

  RxBool saveError = false.obs;
  RxString saveErrorMessage = "".obs;

  // Update user details
  Future<void> updateUserDetails(
      String name, String email, String phone) async {
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };

        final response = await dio.put(
          "${ApiUrl!}/LearnerProfile/Update",
          options: Options(
            headers: headers,
          ),
          data: {
            "fullName": name,
            "email": email,
            "phoneNumber": phone,
          },
        );

        if (response.statusCode == 204) {
          // get new data
          getUserDetails();
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        saveError.value = true;
        saveErrorMessage.value = "We had a problem saving your details.";
      } else {
        // Other errors like network issues
        saveError.value = true;
        saveErrorMessage.value =
            "Check your internet connection and try again.";
      }
    } catch (e) {
      // Handle any exceptions
      saveError.value = true;
      saveErrorMessage.value = "An Error occured. Please try again later.";
    }
  }

  void resetController() {
    saveError.value = false;
    saveErrorMessage.value = "";
  }
}
