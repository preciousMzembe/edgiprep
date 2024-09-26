import 'package:dio/dio.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/models/subject_model.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectsSettingsController extends GetxController {
  UserController userController = Get.find<UserController>();
  final RxList allSubjects = [].obs;
  final RxList selectedSubjects = [].obs;

  Future<void> getAllSubjects() async {
    var userExam = userController.currentExam;

    if (userController.currentExam.isNotEmpty) {
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

          allSubjects.value = tempSubjects;

          // get user current subjects
          getCurrentSubjects();
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

  // Get Current Subjects
  Future<void> getCurrentSubjects() async {
    // get current exam
    Map currentExam = userController.currentExam;

    if (currentExam.isNotEmpty) {
      // get subjects errolled exams
      int examId = currentExam['examId'];
      try {
        String? key = await secureStorage.readKey("userKey");

        if (key != null && key.isNotEmpty) {
          final Map<String, dynamic> headers = {
            'AuthKey': key,
            'Content-Type': 'application/json',
          };
          final response = await dio.get(
            "${ApiUrl!}/SubjectsEnrolled?examId=$examId",
            options: Options(
              headers: headers,
            ),
          );

          if (response.statusCode == 200) {
            // Update user Subjects
            var subjectsData = response.data;

            List tempSubjects = [];
            for (var i = 0; i < subjectsData.length; i++) {
              Map<String, dynamic>? subjectWithId = allSubjects.firstWhere(
                (subject) =>
                    subject['subjectId'] ==
                    subjectsData[i]['subject']['subjectId'],
                orElse: () => null,
              );
              if (subjectWithId != null) {
                tempSubjects.add(subjectWithId);
              }
            }

            // change selected subjects
            selectedSubjects.value = tempSubjects;
          }
        }
      } on DioException catch (e) {
        if (e.response != null) {
          debugPrint(
              "error getting subjects -------------------------------- enrolled subjects");
        } else {
          // Other errors like network issues
          debugPrint(
              "error getting subjects -------------------------------- enrolled subjects - connection");
        }
      } catch (e) {
        // Handle any exceptions
        debugPrint(
            "error getting subjects -------------------------------- enrolled subjects - error occured");
      }
    }
  }
}
