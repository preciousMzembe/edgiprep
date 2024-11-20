import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/exam/exam.dart';
import 'package:edgiprep/db/subject/subject.dart';
import 'package:edgiprep/services/config/config_Service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edgiprep/models/exams/enrollment_exam_model.dart';
import 'package:edgiprep/models/subjects/enrollment_subject_model.dart';

class EnrollmentService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  late Config? config;
  final Dio _dio = createDio();

  // variable to trigger functions in other controllers after fetch is done
  RxBool doneFetchingExams = true.obs;

  // Ensure data is fetched upon initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    config = await configService.getConfig();
    await _fetchServerData();
  }

  // Initialize exams and subjects by fetching from server
  Future<void> _fetchServerData() async {
    config ??= await configService.getConfig();
    await getServerExams();
    await getServerSubjects();
  }

  Future<void> getServerExams() async {
    try {
      final response = await _dio.get("${config?.apiUrl}/Exam/Exams");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<Exam> serverExams = [];

        if (data.isNotEmpty) {
          for (var exam in data) {
            serverExams.add(Exam(id: exam['id'], title: exam['name']));
          }
        }

        // save local
        await examBox.clear();
        await examBox.addAll(serverExams);

        doneFetchingExams.value = !doneFetchingExams.value;
      } else {
        debugPrint(
            "Error fetching exams ------------------------- enrollment service");
      }
    } catch (e) {
      debugPrint(
          "Error fetching exams ------------------------- enrollment service : error");
    }
  }

  Future<void> getServerSubjects() async {
    // Make network request
    try {
      List<EnrollmentExamModel> exams = await getExams();

      if (exams.isNotEmpty) {
        List<Subject> serverSubjects = [];

        for (EnrollmentExamModel exam in exams) {
          final response = await _dio
              .get("${config?.apiUrl}/Subject/Subjects?ExamId=${exam.id}");

          if (response.statusCode == 200) {
            List<dynamic> data = response.data;

            if (data.isNotEmpty) {
              for (var subject in data) {
                serverSubjects.add(
                  Subject(
                    id: subject['id'],
                    title: subject['name'],
                    icon: subject['icon'],
                    examId: subject['examId'],
                  ),
                );
              }
            }
          } else {
            debugPrint(
                "Error fetching subjects ------------------------- enrollment service");
          }
        }

        // save local data
        await subjectBox.clear();
        await subjectBox.addAll(serverSubjects);
      }
    } catch (e) {
      debugPrint(
          "Error fetching subjects --------------------------- enrollment service : error");
    }
  }

  // Public getter for exams
  Future<List<EnrollmentExamModel>> getExams() async {
    List<EnrollmentExamModel> exams = [];

    for (Exam exam in examBox.values) {
      exams.add(
        EnrollmentExamModel(id: exam.id, name: exam.title),
      );
    }

    return exams;
  }

  // Public getter for subjects by exam ID
  Future<List<EnrollmentSubjectModel>> getSubjectsByExamId(
      String examId) async {
    List<EnrollmentSubjectModel> subjects = [];

    for (Subject subject in subjectBox.values) {
      if (subject.examId == examId) {
        subjects.add(EnrollmentSubjectModel(
          id: subject.id,
          name: subject.title,
          icon: subject.icon,
        ));
      }
    }

    return subjects;
  }
}
