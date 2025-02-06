import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/past%20paper/past_paper.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/db/unit/unit.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:get/get.dart';

class UserEnrollmentController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();

  RxList<UserExam> exams = <UserExam>[].obs;
  RxList<UserSubject> subjects = <UserSubject>[].obs;

  @override
  void onInit() async {
    super.onInit();

    getData();

    // listen to change in user data
    ever(userEnrollmentService.doneFetchingUserExams, (_) async {
      fetchExams();
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
    fetchSubjects();
  }

  // Fetch exams
  Future<void> fetchExams() async {
    exams.value = await userEnrollmentService.getExams();
  }

  // Fetch subjects
  Future<void> fetchSubjects() async {
    subjects.value = await userEnrollmentService.getSubjects();
  }

  // Fetch units and topics
  Future<Map<Unit, List<Topic>>> fetchUnitsAndTopics(String subjectEnrollmentId) async {
    Map<Unit, List<Topic>> unitTopicMap =
        await userEnrollmentService.getUnitsAndTopics(subjectEnrollmentId);

    return unitTopicMap;
  }

  // Fetch Topic Lessons
  Future<List<Lesson>> fetchTopicLessons(String topicId) async {
    return await userEnrollmentService.getTopicLessons(topicId);
  }

  // Fetch Subject Papers
  Future<List<PastPaper>> fetchSubjectPapers(String subjectId) async {
    return await userEnrollmentService.getSubjectPapers(subjectId);
  }
}
