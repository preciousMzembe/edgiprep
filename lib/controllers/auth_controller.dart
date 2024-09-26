import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/models/exam_model.dart';
import 'package:edgiprep/models/subject_model.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class AuthController extends GetxController {
  UserController userController = Get.find<UserController>();
  final secureStorage = SecureStorageService();
  final Dio dio = Dio();

  // Auth variables
  RxString logUsername = "".obs;
  RxString logPin = "".obs;
  RxBool hideLogPin = true.obs;

  RxBool hideSignPin = true.obs;
  RxBool hideVerifyPin = true.obs;

  RxBool logError = false.obs;
  RxString logErrorMessage = "".obs;
  RxBool nameError = false.obs;
  RxString nameErrorMessage = "".obs;
  RxBool signPinError = false.obs;

  // Preferences variables
  final RxList _exams = [].obs;
  final RxMap _userExam = {}.obs;

  final RxList _subjects = [].obs;
  final RxList _userSubjects = [].obs;

  final RxString _fullName = "".obs;
  final RxString _username = "".obs;
  final RxString _pin = "".obs;
  final RxString _verifyPin = "".obs;

  List get exams => _exams;
  Map get userExam => _userExam;
  List get subjects => _subjects;
  List get userSubjects => _userSubjects;
  String get fullName => _fullName.value;
  String get username => _username.value;
  String get pin => _pin.value;
  String get verifyPin => _verifyPin.value;

  Future<void> emptySubjects() async {
    _subjects.value = [];
  }

  Future<void> emptyUserSubjects() async {
    _userSubjects.value = [];
  }

  Future<void> setExams() async {
    try {
      final response = await dio.get(
        "${ApiUrl!}/Exam/Exams",
      );

      if (response.statusCode == 200) {
        // Update Exams List
        var examsData = response.data;

        List tempExams = [];
        for (var i = 0; i < examsData.length; i++) {
          ExamModel exam = ExamModel(
              examId: examsData[i]['examId'],
              examName: examsData[i]['examAbbreviation']);

          tempExams.add(exam.toMap);
        }

        _exams.value = tempExams;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint("${e.response} ---------------- auth exams.");
      } else {
        // Other errors like network issues
        debugPrint("Connection error ------------------- auth exams.");
      }
    } catch (e) {
      // Handle any exceptions
      debugPrint("An Error occured ------------ auth exams");
    }
  }

  Future<void> setSubjects() async {
    if (userExam.isNotEmpty) {
      try {
        final response = await dio.get(
          "${ApiUrl!}/Subjects/GetByExamId/${userExam['examId']}",
        );

        if (response.statusCode == 200) {
          // Update Exams List
          var subjectsData = response.data;
          List tempSubjects = [];
          for (var i = 0; i < subjectsData.length; i++) {
            SubjectModel subject = SubjectModel(
              subjectId: subjectsData[i]['esInstance']['insanceId'],
              subjectName: subjectsData[i]['subjectName'],
              subjectDescription: subjectsData[i]['subjectDescription'],
              subjectImage: subjectsData[i]['subjectLink'],
              slidesNumber: 0,
              slidesDone: 0,
            );

            tempSubjects.add(subject.toMap);
          }

          _subjects.value = tempSubjects;
        }
      } on DioException catch (e) {
        if (e.response != null) {
          debugPrint("${e.response} ---------------- auth subjects.");
        } else {
          // Other errors like network issues
          debugPrint("Connection error ------------------- auth subjects.");
        }
      } catch (e) {
        // Handle any exceptions
        debugPrint("An Error occured ------------ auth subjects");
      }
    }
  }

  void setUserExam(Map exam) {
    _userExam.value = exam;
  }

  void addRemoveUserSubjects(Map subject) {
    if (!userSubjects.contains(subject)) {
      _userSubjects.add(subject);
    } else {
      _userSubjects.remove(subject);
    }
  }

  void setFullName(String name) {
    _fullName.value = name;
  }

  void setUsername(String username) {
    _username.value = username;
  }

  void setPin(String pin) {
    _pin.value = pin;
  }

  void setVerifyPin(String pin) {
    _verifyPin.value = pin;
  }

  // reset controller
  void resetController() {
    _userExam.value = {};
    _userSubjects.value = [];
    _fullName.value = "";
    _username.value = "";
    _pin.value = "";
    _verifyPin.value = "";

    logError = false.obs;
    logErrorMessage = "".obs;
    nameError = false.obs;
    nameErrorMessage = "".obs;
    signPinError = false.obs;

    setExams();
  }

  // Register and Login functions
  Future<bool> register() async {
    String subjectsIds = "";
    for (int i = 0; i < userSubjects.length; i++) {
      if (i == 0) {
        subjectsIds = "$subjectsIds${userSubjects[i]['subjectId']}";
      } else {
        subjectsIds = "$subjectsIds<=>${userSubjects[i]['subjectId']}";
      }
    }
    try {
      final response = await dio.post(
        "${ApiUrl!}/Register",
        data: {
          "fullName": fullName,
          "username": username,
          "password": pin,
          "device": userController.deviceId,
        },
      );

      if (response.statusCode == 200) {
        // Save user key
        String key = response.data['key'];

        if (key.isNotEmpty) {
          // enroll exam and subjects
          final Map<String, dynamic> headers = {
            'AuthKey': key,
            'Content-Type': 'application/json',
          };
          final response = await dio.post(
            "${ApiUrl!}/Enrollment",
            data: {
              "examId": userExam['examId'],
              "ids": subjectsIds,
            },
            options: Options(
              headers: headers,
            ),
          );

          if (response.statusCode == 200) {
            // login
            await secureStorage.writeKey("userKey", key);
            userController.checkUserKey();

            return true;
          }
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        nameError.value = true;
        nameErrorMessage.value = "username already taken.";
      } else {
        // Other errors like network issues
        nameError.value = true;
        nameErrorMessage.value =
            "Check your internet connection and try again.";
      }
    } catch (e) {
      // Handle any exceptions
      nameErrorMessage.value = "An Error occured. Please try again later.";
    }

    return false;
  }

  Future<void> login() async {
    if (logUsername.isNotEmpty && logPin.isNotEmpty) {
      try {
        final Map<String, dynamic> headers = {
          'Content-Type': 'application/json',
        };

        final response = await dio.post(
          "${ApiUrl!}/login",
          options: Options(
            headers: headers,
          ),
          data: {
            'Username': logUsername.value,
            'Password': logPin.value,
            "Device": "23456",
            // "Device": userController.deviceId,
          },
        );

        if (response.statusCode == 200) {
          // Save user key
          String key = response.data['key'];
          if (key.isNotEmpty) {
            await secureStorage.writeKey("userKey", key);
            userController.checkUserKey();

            // empty login details
            logUsername.value = "";
            logPin.value = "";
          }
        }
      } on DioException catch (e) {
        if (e.response != null) {
          logError.value = true;
          logErrorMessage.value = "Wrong Username or Pin.";
        } else {
          // Other errors like network issues
          logError.value = true;
          logErrorMessage.value =
              "Check your internet connection and try again.";
        }
      } catch (e) {
        // Handle any exceptions
        logError.value = true;
        logErrorMessage.value = "An Error occured. Please try again later.";
      }
    }
  }

  // initialize data
  @override
  Future<void> onInit() async {
    super.onInit();

    // Preferences
    setExams();
  }
}
