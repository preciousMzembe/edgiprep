import 'package:dio/dio.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/models/exam_model.dart';
import 'package:edgiprep/models/subject_model.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExamController extends GetxController {
  UserController userController = Get.find<UserController>();
  final secureStorage = SecureStorageService();
  final Dio dio = Dio();

  // Preferences variables
  final RxList _exams = [].obs;
  final RxMap _userExam = {}.obs;

  final RxList _subjects = [].obs;
  final RxList _userSubjects = [].obs;

  List get exams => _exams;
  Map get userExam => _userExam;
  List get subjects => _subjects;
  List get userSubjects => _userSubjects;

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

          if (!userController.userExams
              .any((map) => map['examId'] == exam.examId)) {
            tempExams.add(exam.toMap);
          }
        }

        _exams.value = tempExams;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint("${e.response} ---------------- add exam exams.");
      } else {
        // Other errors like network issues
        debugPrint("Connection error ------------------- add exam exams.");
      }
    } catch (e) {
      // Handle any exceptions
      debugPrint("An Error occured ------------ add exam exams");
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
            // TODO: use instance id
            SubjectModel subject = SubjectModel(
              subjectId: subjectsData[i]['subjectId'],
              subjectName: subjectsData[i]['subjectName'],
              subjectDescription: subjectsData[i]['subjectDescription'],
              subjectImage: subjectsData[i]['subjectLink'],
            );

            tempSubjects.add(subject.toMap);
          }

          _subjects.value = tempSubjects;
        }
      } on DioException catch (e) {
        if (e.response != null) {
          debugPrint("${e.response} ---------------- add exam subjects.");
        } else {
          // Other errors like network issues
          debugPrint("Connection error ------------------- add exam subjects.");
        }
      } catch (e) {
        // Handle any exceptions
        debugPrint("An Error occured ------------ add exam subjects");
      }
    }
  }

  Future<bool> enrollExam() async {
    String? storedUserKey = await secureStorage.readKey("userKey");
    String subjectsIds = "";
    for (int i = 0; i < userSubjects.length; i++) {
      if (i == 0) {
        subjectsIds = "$subjectsIds${userSubjects[i]['subjectId']}";
      } else {
        subjectsIds = "$subjectsIds<=>${userSubjects[i]['subjectId']}";
      }
    }
    try {
      if (storedUserKey != null && storedUserKey.isNotEmpty) {
        // enroll exam and subjects
        final Map<String, dynamic> headers = {
          'AuthKey': storedUserKey,
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
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
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

  // reset controller
  void resetController() {
    _userExam.value = {};
    _userSubjects.value = [];
  }

  // initialize data
  @override
  void onInit() {
    super.onInit();

    // Preferences
    setExams();
  }
}
