import 'package:dio/dio.dart';
import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/exam/exam.dart';
import 'package:edgiprep/db/subject/subject.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/config/config_Service.dart';
import 'package:edgiprep/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edgiprep/models/exams/enrollment_exam_model.dart';
import 'package:edgiprep/models/subjects/enrollment_subject_model.dart';

class EnrollmentService extends GetxService {
  ConfigService configService = Get.find<ConfigService>();
  AuthService authService = Get.find<AuthService>();

  late Config? config;
  final Dio _dio = createDio();

  // variable to trigger functions in other controllers after fetch is done
  RxBool doneFetchingExams = true.obs;
  RxBool doneEnrollment = true.obs;

  // Ensure data is fetched upon initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    config = await configService.getConfig();
    await _fetchServerData();

    config ??= await configService.getConfig();
  }

  Future<void> restartFetch() async {
    await _fetchServerData();
  }

  // Initialize exams and subjects by fetching from server
  Future<void> _fetchServerData() async {
    config ??= await configService.getConfig();

    // check if token is not empty first
    String? token = await authService.getToken();

    if (token != null && token != '') {
      await getServerExams();
      await getServerSubjects();

      doneFetchingExams.value = !doneFetchingExams.value;
    }
  }

  Future<void> getServerExams() async {
    try {
      String? token = await authService.getToken();

      final response = await _dio.get(
        '${config?.apiUrl}/Exam/Exams',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Exam> serverExams = [];

        List<dynamic> data = response.data;

        if (data.isNotEmpty) {
          for (var exam in data) {
            serverExams.add(
              Exam(id: exam['id'], title: exam['name']),
            );
          }
        }

        // save local
        await examBox.clear();
        await examBox.addAll(serverExams);
      }
    } on DioException catch (e) {
      debugPrint(
          "Error fetching exams ------------------------- enrollment service");
    }
  }

  Future<void> getServerSubjects() async {
    try {
      List<EnrollmentExamModel> exams = await getExams();

      if (exams.isNotEmpty) {
        List<Subject> serverSubjects = [];

        for (EnrollmentExamModel exam in exams) {
          // get subject exams
          List<Subject> subjects = await getExamSubjects(exam.id);

          if (subjects.isNotEmpty) {
            for (Subject subject in subjects) {
              serverSubjects.add(subject);
            }
          }
        }

        // save local data
        await subjectBox.clear();
        await subjectBox.addAll(serverSubjects);
      }
    } on DioException catch (e) {
      debugPrint(
          "Error fetching subjects --------------------------- enrollment service ");
    }
  }

  Future<List<Subject>> getExamSubjects(String id) async {
    List<Subject> serverSubjects = [];
    try {
      String? token = await authService.getToken();

      final response = await _dio.get(
        '${config?.apiUrl}/Subject/Subjects?ExamId=$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        for (var subject in data) {
          serverSubjects.add(
            Subject(
              id: subject['id'],
              title: subject['name'],
              icon: "biology.svg",
              examId: subject['examId'],
            ),
          );
        }
      }
    } on DioException catch (e) {
      debugPrint(
          "Error fetching exam subjects ------------------------- enrollment service");
    }

    return serverSubjects;
  }

  // Enrollment Process
  Future<bool> enroll(String examId, List<String> subjects) async {
    bool done = false;

    try {
      String? token = await authService.getToken();

      final response =
          await _dio.post('${config?.apiUrl}/Enrollment/Mobile/Enroll',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              data: {
            "examId": examId,
            "subjects": subjects,
          });

      if (response.statusCode == 200) {
        done = true;
        doneEnrollment.value = !doneEnrollment.value;
      }
    } on DioException catch (e) {
      debugPrint(
          "Error enrolling ------------------------- enrollment service");
    }

    return done;
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
