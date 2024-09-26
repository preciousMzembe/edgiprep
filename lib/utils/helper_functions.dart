import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/models/exam_model.dart';
import 'package:edgiprep/models/lesson_model.dart';
import 'package:edgiprep/models/paper_model.dart';
import 'package:edgiprep/models/subject_model.dart';
import 'package:edgiprep/models/topic_model.dart';
import 'package:edgiprep/models/user_model.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/secure_storage.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

UserController userController = Get.find<UserController>();
final secureStorage = SecureStorageService();
final Dio dio = Dio();

// Get all offline data
Future<void> getOfflineData() async {
  // get local user details

  String? userString = await secureStorage.readKey('user');

  if (userString != null && userString.isNotEmpty) {
    Map<dynamic, dynamic> user =
        Map<dynamic, dynamic>.from(jsonDecode(userString));
    userController.user.value = user;
  }

  // get local user exams

  String? examsString = await secureStorage.readKey('userExams');

  if (examsString != null && examsString.isNotEmpty) {
    List userExams = List.from(jsonDecode(examsString));
    userController.userExams.value = userExams;
  }

  // get local current subjects

  String? subjectsString = await secureStorage.readKey('currentSubjects');

  if (subjectsString != null && subjectsString.isNotEmpty) {
    List currentSubjects = List.from(jsonDecode(subjectsString));
    userController.currentSubjects.value = currentSubjects;
  }

  // get local subjects topics

  String? topicsString = await secureStorage.readKey('subjectsTopics');

  if (topicsString != null && topicsString.isNotEmpty) {
    Map subjectsTopics = Map.from(jsonDecode(topicsString));
    userController.subjectsTopics.value = subjectsTopics;
  }

  // get local subjects topics

  String? lessonsString = await secureStorage.readKey('topicsLessons');

  if (lessonsString != null && lessonsString.isNotEmpty) {
    Map topicsLessons = Map.from(jsonDecode(lessonsString));
    userController.topicsLessons.value = topicsLessons;
  }

  // get local subjects papers
  String? papersString = await secureStorage.readKey('subjectsPapers');

  if (papersString != null && papersString.isNotEmpty) {
    // update from storage
    Map subjectsPapers = Map.from(jsonDecode(papersString));
    userController.subjectsPapers.value = subjectsPapers;
  }
}

// Get User Details
Future<void> getUserDetails() async {
  try {
    String? key = await secureStorage.readKey("userKey");

    // get local user details

    String? userString = await secureStorage.readKey('user');

    if (userString != null && userString.isNotEmpty) {
      // update from storage
      Map<dynamic, dynamic> user =
          Map<dynamic, dynamic>.from(jsonDecode(userString));
      userController.user.value = user;
    }

    // get internet data

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

        UserModel userModel = UserModel(
          userId: userData['learnerId'],
          fullName: userData['learnerFullName'],
          username: userData['learnerUsername'],
          email: userData['learnerEmail'],
          phone: userData['learnerPhoneNumber'],
          xps: userData['learnerXp'],
          streaks: userData['streaks'],
        );

        userController.user.value = userModel.toMap;

        // save local
        String jsonString = jsonEncode(userModel.toMap);
        await secureStorage.writeKey("user", jsonString);
      }
    }
  } on DioException catch (e) {
    if (e.response != null) {
      var errorData = e.response!.data;
      if (errorData is Map &&
          errorData.containsKey('Detail') &&
          errorData['Detail'] != null &&
          errorData['Detail'] == "Unauthorized Request") {
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
    print(e);
    debugPrint(
        "error getting user details -------------------------------- user details - error occured");
  }
}

// Get User Exams
Future<void> getExams() async {
  try {
    String? key = await secureStorage.readKey("userKey");

    // get local user exams

    String? examsString = await secureStorage.readKey('userExams');

    if (examsString != null && examsString.isNotEmpty) {
      // update from storage
      List userExams = List.from(jsonDecode(examsString));
      userController.userExams.value = userExams;
    }

    // get internet data

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

        // save local
        String jsonString = jsonEncode(tempExams);
        await secureStorage.writeKey("userExams", jsonString);
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

Future<void> changeExam(Map exam) async {
  var tempExam = exam;
  String jsonString = jsonEncode(tempExam);
  await secureStorage.writeKey("currentExam", jsonString);

  userController.checkUserKey();
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

      // get local current subjects

      String? subjectsString = await secureStorage.readKey('currentSubjects');

      if (subjectsString != null && subjectsString.isNotEmpty) {
        // update from storage
        List currentSubjects = List.from(jsonDecode(subjectsString));
        userController.currentSubjects.value = currentSubjects;
      }

      // get internet data

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
            var subjectId = subjectsData[i]['esInstance']['insanceId'];
            // get progress
            final progressResponse = await dio.get(
              "${ApiUrl!}/Progress/GetSubjectProgress?subjectId=$subjectId",
              options: Options(
                headers: headers,
              ),
            );

            if (progressResponse.statusCode == 200) {
              var progressData = progressResponse.data;

              SubjectModel subject = SubjectModel(
                subjectId: subjectId,
                subjectName: subjectsData[i]['subject']['subjectName'],
                subjectDescription: subjectsData[i]['subject']
                    ['subjectDescription'],
                subjectImage: subjectsData[i]['subject']['subjectLink'],
                slidesNumber: progressData['total'],
                slidesDone: progressData['done'],
              );

              tempSubjects.add(subject.toMap);
            }
          }

          // change subjects in user controller
          userController.currentSubjects.value = tempSubjects;

          // save local
          String jsonString = jsonEncode(tempSubjects);
          await secureStorage.writeKey("currentSubjects", jsonString);

          // get topics of subjects
          getTopicsOfCurrentSubjects();

          // Get past papers for all subjects
          getSubjectsPapers();
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
            slidesNumber: 0,
            slidesDone: 0,
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

  // get local subjects topics

  String? key = await secureStorage.readKey("userKey");

  String? topicsString = await secureStorage.readKey('subjectsTopics');

  if (topicsString != null && topicsString.isNotEmpty) {
    // update from storage
    Map subjectsTopics = Map.from(jsonDecode(topicsString));
    userController.subjectsTopics.value = subjectsTopics;
    tempSubjectsTopics = subjectsTopics;
  }

  // get internet data

  for (var i = 0; i < subjects.length; i++) {
    // get topics of subject
    int instanceId = subjects[i]['subjectId'];
    try {
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
            var topicId = topicsData[x]['topicId'];
            // get progress
            final progressResponse = await dio.get(
              "${ApiUrl!}/Progress/GetTopicProgress?topicId=$topicId",
              options: Options(
                headers: headers,
              ),
            );

            if (progressResponse.statusCode == 200) {
              var progressData = progressResponse.data;

              TopicModel topic = TopicModel(
                topicId: topicId,
                topicName: topicsData[x]['topicName'],
                topicColor: getRandomHexColor(),
                slidesNumber: progressData['total'],
                slidesDone: progressData['done'],
              );

              tempTopics.add(topic.toMap);
            }
          }

          tempSubjectsTopics[instanceId.toString()] = tempTopics;
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

  // save local
  String jsonString = jsonEncode(tempSubjectsTopics);
  await secureStorage.writeKey("subjectsTopics", jsonString);

  // get Lessons of Topics
  getLessonsOfTopics();
}

// Get Lessons of Topics
Future<void> getLessonsOfTopics() async {
  Map subjectsTopics = userController.subjectsTopics;

  Map tempTopicsLessons = {};

  // get local subjects topics

  String? key = await secureStorage.readKey("userKey");

  String? lessonsString = await secureStorage.readKey('topicsLessons');

  if (lessonsString != null && lessonsString.isNotEmpty) {
    // update from storage
    Map topicsLessons = Map.from(jsonDecode(lessonsString));
    userController.topicsLessons.value = topicsLessons;
    tempTopicsLessons = topicsLessons;
  }

  for (var subjectTopics in subjectsTopics.entries) {
    // get Lessons of topic
    for (var i = 0; i < subjectTopics.value.length; i++) {
      var topic = subjectTopics.value[i];
      int topicId = topic['topicId'];

      try {
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
            int currentLesson = 0;
            for (var x = 0; x < lessonsData.length; x++) {
              var lessonId = lessonsData[x]['lessonId'];
              // get progress
              final progressResponse = await dio.get(
                "${ApiUrl!}/Progress/GetLessonProgress?lessonId=$lessonId",
                options: Options(
                  headers: headers,
                ),
              );

              if (progressResponse.statusCode == 200) {
                var progressData = progressResponse.data;

                bool lessonDone = false;

                if (progressData['total'] > 0 &&
                    progressData['done'] == progressData['total']) {
                  lessonDone = true;
                  currentLesson += 1;
                }

                LessonModel lesson = LessonModel(
                  lessonId: lessonId,
                  lessonName: lessonsData[x]['lessonTitle'],
                  slidesNumber: progressData['total'],
                  slidesDone: progressData['done'],
                  currentLesson: currentLesson == x,
                  finalLesson: x == lessonsData.length - 1,
                  lessonDone: lessonDone,
                );

                tempLessons.add(lesson.toMap);
              }
            }

            tempTopicsLessons[topicId.toString()] = tempLessons;
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

  // save local
  String jsonString = jsonEncode(tempTopicsLessons);
  await secureStorage.writeKey("topicsLessons", jsonString);
}

// Get Past Papers
Future<void> getSubjectsPapers() async {
  var subjects = userController.currentSubjects;

  Map tempSubjectsPapers = {};

  // get local subjects papers

  String? key = await secureStorage.readKey("userKey");

  String? papersString = await secureStorage.readKey('subjectsPapers');

  if (papersString != null && papersString.isNotEmpty) {
    // update from storage
    Map subjectsPapers = Map.from(jsonDecode(papersString));
    userController.subjectsPapers.value = subjectsPapers;
  }

  // get internet data

  for (var i = 0; i < subjects.length; i++) {
    // get papers of subject
    int instanceId = subjects[i]['subjectId'];
    try {
      if (key != null && key.isNotEmpty) {
        final Map<String, dynamic> headers = {
          'AuthKey': key,
          'Content-Type': 'application/json',
        };
        final response = await dio.get(
          "${ApiUrl!}/PastPaper/PastPapersWithInstanceId?instanceId=$instanceId",
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          // Update user Papers
          var papersData = response.data;

          List tempPapers = [];
          for (var x = 0; x < papersData.length; x++) {
            PaperModel paper = PaperModel(
              paperId: papersData[x]['pastPaperId'],
              paperName: papersData[x]['pastPaperName'],
              paperDate: papersData[x]['pastPaperDate'] ?? "March 20, 2020",
              paperDuration: papersData[x]['paperDuration'] ?? "2 hours",
              paperDone: papersData[x]['paperDone'] ?? false,
            );

            tempPapers.add(paper.toMap);
          }

          tempSubjectsPapers[instanceId.toString()] = tempPapers;

          // Change Subjects Papers
          userController.subjectsPapers.value = tempSubjectsPapers;

          // save local
          String jsonString = jsonEncode(tempSubjectsPapers);
          await secureStorage.writeKey("subjectsPapers", jsonString);
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "error getting papers -------------------------------- subject papers");
      } else {
        // Other errors like network issues
        debugPrint(
            "error getting papers -------------------------------- subject papers - connection");
      }
    } catch (e) {
      // Handle any exceptions
      debugPrint(
          "error getting papers -------------------------------- subject papers - error occured");
    }
  }
}

Future<void> logout() async {
  await secureStorage.writeKey("userKey", "");
  await secureStorage.writeKey("currentExam", "");

  // User details
  userController.user = {}.obs;
  userController.streak = "".obs;
  userController.practiceHours = "".obs;

  userController.userExams = [].obs;
  userController.currentExam = {}.obs;
  userController.currentSubjects = [].obs;
}
