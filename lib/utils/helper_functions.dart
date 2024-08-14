import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/models/exam_model.dart';
import 'package:edgiprep/models/lesson_model.dart';
import 'package:edgiprep/models/subject_model.dart';
import 'package:edgiprep/models/topic_model.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

UserController userController = Get.find<UserController>();
final secureStorage = SecureStorageService();
final Dio dio = Dio();

// Get User Details
Future<void> getUserDetails() async {
  try {
    String? key = await secureStorage.readKey("userKey");

    if (key != null && key.isNotEmpty) {
      final Map<String, dynamic> headers = {
        'AuthKey': key,
        'Content-Type': 'application/json',
      };
      final response = await dio.get(
        "${ApiUrl!}/LearnerProfile",
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // Update user details
        var userData = response.data;

        userController.fullName.value = userData['learnerFullName'];
        userController.userName.value = userData['learnerUsername'];
        userController.xps.value = userData['learnerXp'].toString();
        // userController.streak.value = userData;
        // userController.practiceHours.value = userData;
      }
    }
  } on DioException catch (e) {
    if (e.response != null) {
      var errorData = e.response!.data;
      if (errorData?['Detail'] != null &&
          errorData?['Detail'] == "Unauthorized Request") {
        // logout
        await secureStorage.writeKey("userKey", "");
        userController.changeUserKey("");
      }
      debugPrint(
          "error getting user details -------------------------------- user details");
    } else {
      // Other errors like network issues
      debugPrint(
          "error getting user details -------------------------------- user details - connection");
    }
  } catch (e) {
    // Handle any exceptions
    debugPrint(
        "error getting user details -------------------------------- user details - error occured");
  }
}

// Get User Exams
Future<void> getExams() async {
  try {
    String? key = await secureStorage.readKey("userKey");

    if (key != null && key.isNotEmpty) {
      final Map<String, dynamic> headers = {
        'AuthKey': key,
        'Content-Type': 'application/json',
      };
      final response = await dio.get(
        "${ApiUrl!}/ExamsEnrolled",
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // Update user Exams
        var examsData = response.data;

        List tempExams = [];
        for (var i = 0; i < examsData.length; i++) {
          ExamModel exam = ExamModel(
              examId: examsData[i]['examId'],
              examName: examsData[i]['examAbbreviation']);

          tempExams.add(exam.toMap);
        }

        // changr exams in user controller
        userController.userExams.value = tempExams;
      }
    }
  } on DioException catch (e) {
    if (e.response != null) {
      debugPrint(
          "error getting exams -------------------------------- enrolled exams");
    } else {
      // Other errors like network issues
      debugPrint(
          "error getting exams -------------------------------- enrolled exams - connection");
    }
  } catch (e) {
    // Handle any exceptions
    debugPrint(
        "error getting exams -------------------------------- enrolled exams - error occured");
  }
}

// Set Current Exam
Future<void> setCurrentExam() async {
  // get from storage
  String? jsonString = await secureStorage.readKey('currentExam');

  if (jsonString != null && jsonString.isNotEmpty) {
    // update from storage
    Map<dynamic, dynamic> currentExam =
        Map<dynamic, dynamic>.from(jsonDecode(jsonString));
    userController.currentExam.value = currentExam;
  } else {
    // get first from user exams
    var tempExam = userController.userExams[0];
    String jsonString = jsonEncode(tempExam);
    await secureStorage.writeKey("currentExam", jsonString);
    userController.currentExam.value = tempExam;
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

          // print(subjectsData);

          List tempSubjects = [];
          for (var i = 0; i < subjectsData.length; i++) {
            SubjectModel subject = SubjectModel(
              subjectId: subjectsData[i]['esInstance']['insanceId'],
              subjectName: subjectsData[i]['subject']['subjectName'],
              subjectDescription: subjectsData[i]['subject']
                  ['subjectDescription'],
              subjectImage: subjectsData[i]['subject']['subjectLink'],
            );

            tempSubjects.add(subject.toMap);
          }

          // change subjects in user controller
          userController.currentSubjects.value = tempSubjects;

          // get topics of subjects
          getTopicsOfCurrentSubjects();
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

Future<void> getUnenrolledSubjects() async {
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
            subjectId: subjectsData[i]['subjectId'],
            subjectName: subjectsData[i]['subjectName'],
            subjectDescription: subjectsData[i]['subjectDescription'],
            subjectImage: subjectsData[i]['subjectLink'],
          );

          bool currentSubjectsHaveSubjectWithId = userController.currentSubjects
              .any((subject) =>
                  subject['subjectId'] == subjectsData[i]['subjectId']);

          if (!currentSubjectsHaveSubjectWithId) {
            // add subject
            tempSubjects.add(subject.toMap);
          }
        }

        userController.unerolledSubjects.value = tempSubjects;
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

// Get Topics of Current Subjects
Future<void> getTopicsOfCurrentSubjects() async {
  var subjects = userController.currentSubjects;

  Map tempSubjectsTopics = {};

  for (var i = 0; i < subjects.length; i++) {
    // get topics of subject
    int instanceId = subjects[i]['subjectId'];
    try {
      String? key = await secureStorage.readKey("userKey");

      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.get(
          "${ApiUrl!}/Topic/Topics/?instanceId=$instanceId",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Update user Topics
          var topicsData = response.data;

          List tempTopics = [];
          for (var x = 0; x < topicsData.length; x++) {
            TopicModel topic = TopicModel(
              topicId: topicsData[x]['topicId'],
              topicName: topicsData[x]['topicName'],
              topicColor: getRandomColor(),
            );

            tempTopics.add(topic.toMap);
          }

          tempSubjectsTopics[instanceId] = tempTopics;
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "error getting topics -------------------------------- subject topics");
      } else {
        // Other errors like network issues
        debugPrint(
            "error getting topics -------------------------------- subject topics - connection");
      }
    } catch (e) {
      // Handle any exceptions
      debugPrint(
          "error getting topics -------------------------------- subject topics - error occured");
    }
  }

  // Change Subjects Topics
  userController.subjectsTopics.value = tempSubjectsTopics;

  // get Lessons of Topics
  getLessonsOfTopics();
}

// Get Lessons of Topics
Future<void> getLessonsOfTopics() async {
  Map subjectsTopics = userController.subjectsTopics;

  Map tempTopicsLessons = {};

  for (var subjectTopics in subjectsTopics.entries) {
    // print('Key: ${topic.key}, Value: ${topic.value}');

    // get Lessons of topic
    for (var i = 0; i < subjectTopics.value.length; i++) {
      var topic = subjectTopics.value[i];
      int topicId = topic['topicId'];

      try {
        String? key = await secureStorage.readKey("userKey");

        if (key != null && key.isNotEmpty) {
          final Map<String, dynamic> headers = {
            'AuthKey': key,
            'Content-Type': 'application/json',
          };
          final response = await dio.get(
            "${ApiUrl!}/Lesson/GetLessons?topicId=$topicId",
            options: Options(
              headers: headers,
            ),
          );

          if (response.statusCode == 200) {
            // Update Lessons
            var lessonsData = response.data;

            List tempLessons = [];
            for (var x = 0; x < lessonsData.length; x++) {
              LessonModel lesson = LessonModel(
                lessonId: lessonsData[x]['lessonId'],
                lessonName: lessonsData[x]['lessonTitle'],
              );

              tempLessons.add(lesson.toMap);
            }

            tempTopicsLessons[topicId] = tempLessons;
          }
        }
      } on DioException catch (e) {
        if (e.response != null) {
          debugPrint(
              "error getting Lessons -------------------------------- topic lessons");
        } else {
          // Other errors like network issues
          debugPrint(
              "error getting Lessons -------------------------------- topic lessons - connection");
        }
      } catch (e) {
        // Handle any exceptions
        debugPrint(
            "error getting Lessons -------------------------------- topic lessons - error occured");
      }
    }
  }

  // Change Topics Lessons
  userController.topicsLessons.value = tempTopicsLessons;
}

Future<void> logout() async {
  await secureStorage.writeKey("userKey", "");
  await secureStorage.writeKey("currentExam", "");

  // User details
  userController.userName = "".obs;
  userController.xps = "".obs;
  userController.streak = "".obs;
  userController.practiceHours = "".obs;

  userController.userExams = [].obs;
  userController.currentExam = {}.obs;
  userController.currentSubjects = [].obs;
}
