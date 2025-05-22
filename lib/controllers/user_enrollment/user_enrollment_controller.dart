import 'dart:math';

import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/mock_exam/mock_exam.dart';
import 'package:edgiprep/db/past_paper/past_paper.dart';
import 'package:edgiprep/db/subject/subject_progress.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/db/unit/unit.dart';
import 'package:edgiprep/models/exams/settings_exam_model.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:get/get.dart';

class UserEnrollmentController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();
  final EnrollmentService enrollmentService = Get.find<EnrollmentService>();

  RxList<UserExam> exams = <UserExam>[].obs;
  RxList<SettingsExamModel> allExams = <SettingsExamModel>[].obs;
  Rx<UserExam> activeExam =
      UserExam(id: "", title: "", selected: false, enrollmentId: "").obs;
  RxList<UserSubject> subjects = <UserSubject>[].obs;

  @override
  void onInit() async {
    super.onInit();

    getData();

    // listen to change in user data
    ever(userEnrollmentService.doneFetchingUserExams, (_) async {
      fetchExams();
      getActiveExam();
    });

    ever(userEnrollmentService.doneFetchingUserSubjects, (_) async {
      fetchSubjects();
    });

    // listed to logout
    ever(authService.doneLogout, (_) async {
      exams.value = <UserExam>[];
    });
  }

  void getData() {
    fetchExams();
    getActiveExam();
    fetchSubjects();
  }

  // Fetch exams
  Future<void> fetchExams() async {
    exams.value = await userEnrollmentService.getExams();
    List serverExams = await enrollmentService.getExams();

    String selectedId = "";

    List<SettingsExamModel> tempExams = [];
    for (var exam in serverExams) {
      var enrolled = exams.firstWhere(
        (e) => e.id == exam.id,
        orElse: () =>
            UserExam(id: "", title: "", selected: false, enrollmentId: ""),
      );

      if (enrolled.id != "") {
        if (enrolled.selected) {
          selectedId = enrolled.id;
        }

        tempExams.add(
          SettingsExamModel(
            id: exam.id,
            enrollmentId: enrolled.enrollmentId,
            name: exam.name,
            selected: enrolled.selected,
          ),
        );
      } else {
        tempExams.add(
          SettingsExamModel(
            id: exam.id,
            enrollmentId: "",
            name: exam.name,
            selected: false,
          ),
        );
      }
    }

    tempExams.sort((a, b) {
      if (a.id == selectedId) return -1;
      if (b.id == selectedId) return 1;
      return 0;
    });

    allExams.value = tempExams;
  }

  Future<void> getActiveExam() async {
    activeExam.value = await userEnrollmentService.getActiveExam();
  }

  Future<void> switchExam(String examId) async {
    await userEnrollmentService.switchExam(examId);
  }

  // Fetch subjects
  Future<void> fetchSubjects() async {
    subjects.value = await userEnrollmentService.getSubjects();
    subjects.shuffle(Random());

    subjects.refresh();
  }

  Future<SubjectProgress> getSubjectProgress(String subjectEnrollmentId) async {
    return await userEnrollmentService.getSubjetProgress(subjectEnrollmentId);
  }

  // Fetch units and topics
  Future<Map<Unit, List<Topic>>> fetchUnitsAndTopics(
      String subjectEnrollmentId) async {
    Map<Unit, List<Topic>> unitTopicMap =
        await userEnrollmentService.getUnitsAndTopics(subjectEnrollmentId);

    return unitTopicMap;
  }

  // Fetch Topic
  Future<Topic> fetchTopic(String topicId, String subjectEnrollmentId) async {
    return await userEnrollmentService.getTopic(topicId, subjectEnrollmentId);
  }

  // Fetch Topic Lessons
  Future<List<Lesson>> fetchTopicLessons(Topic topic) async {
    return await userEnrollmentService.getTopicLessons(topic);
  }

  // Fetch Subject Papers
  Future<List<PastPaper>> fetchSubjectPapers(String subjectId) async {
    return await userEnrollmentService.getSubjectPapers(subjectId);
  }

  int getSubjectPapersCount(String subjectId) {
    return userEnrollmentService.getSubjectPapersCount(subjectId);
  }

  // Fetch Subject Papers
  Future<List<MockExam>> fetchSubjectMocks(String subjectId) async {
    return await userEnrollmentService.getSubjectMocks(subjectId);
  }

  int getSubjectMocksCount(String subjectId) {
    return userEnrollmentService.getSubjectMocksCount(subjectId);
  }

  // Fetch exam subjects
  Future<List<UserSubject>> fetchEnrolledExamSubjects(
      String examEnrollmentId) async {
    return await userEnrollmentService.getSubjectsByExamId(examEnrollmentId);
  }
}
