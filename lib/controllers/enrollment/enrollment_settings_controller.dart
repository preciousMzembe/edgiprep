import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/models/subjects/enrollment_subject_model.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:get/get.dart';

class EnrollmentSettingsController extends GetxController {
  final EnrollmentService enrollmentService = Get.find<EnrollmentService>();
  final UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();

  RxBool examSelected = false.obs;
  RxList<UserExam> exams = <UserExam>[].obs;
  RxList<EnrollmentSubjectModel> subjects = <EnrollmentSubjectModel>[].obs;
  RxList<EnrollmentSubjectModel> enrolledSubjects =
      <EnrollmentSubjectModel>[].obs;
  RxList<EnrollmentSubjectModel> unenrolledSubjects =
      <EnrollmentSubjectModel>[].obs;

  RxBool subjectsSelected = false.obs;

  @override
  void onInit() {
    super.onInit();

    // listen to change in exams fetch
    ever(userEnrollmentService.doneFetchingUserSubjects, (_) {
      fetchExams();
    });
  }

  // Fetch exams
  Future<void> fetchExams() async {
    UserExam exam = await userEnrollmentService.getActiveExam();

    exams.value = [exam];

    if (exams.isNotEmpty) {
      selectExam(exams.first.title);
    }

    subjectsSelected.value = false;
  }

  // unenroll exam
  Future<bool> unenrollExam(String examEnrollmentId) async {
    bool done = await userEnrollmentService.unenrollExam(examEnrollmentId);
    return done;
  }

  Future<bool> checkExamEnrollment(String examId) async {
    return userEnrollmentService.checkExamEnrollment(examId);
  }

  // Enroll new subjects
  Future<bool> enrollSubjects() async {
    String enrollmentId =
        exams.firstWhere((exam) => exam.selected).enrollmentId;

    // Enroll
    List<String> enrollSubjectIds = unenrolledSubjects
        .where((subject) => subject.selected)
        .map((subject) => subject.id)
        .toList();

    bool done = await userEnrollmentService.enrollSubjects(
        enrollmentId, enrollSubjectIds);

    return done;
  }

  Future<bool> enrollSubject(String enrollmentId, String subjectId) async {

    // Enroll
    List<String> enrollSubjectIds = [subjectId];

    bool done = await userEnrollmentService.enrollSubjects(
        enrollmentId, enrollSubjectIds);

    return done;
  }

  // Unenroll subjects
  Future<bool> unenrollSubject(String subjectEnrollmentId) async {
    bool done =
        await userEnrollmentService.unenrollSubject(subjectEnrollmentId);

    return done;
  }

  Future<bool> checkSubjectEnrollment(String subjectId) async {
    return userEnrollmentService.checkSubjectEnrollment(subjectId);
  }

  // Select exam
  void selectExam(String examName) {
    for (var exam in exams) {
      exam.selected = exam.title == examName;
    }
    exams.refresh();
    examSelected.value = true;

    // Load subjects for the selected exam
    var selectedExam = exams.firstWhere((exam) => exam.selected);
    fetchSubjects(selectedExam.id);
  }

  // Fetch subjects by exam ID
  Future<void> fetchSubjects(String examId) async {
    subjects.value = await enrollmentService.getSubjectsByExamId(examId);

    // Enrolled Subjects
    List<EnrollmentSubjectModel> eSubjects0 = [];
    var eSubjects = await userEnrollmentService.getSubjects();

    for (var subject in eSubjects) {
      eSubjects0.add(EnrollmentSubjectModel(
        id: subject.id,
        name: subject.title,
        icon: subject.icon,
      ));
    }

    enrolledSubjects.value = eSubjects0;

    // Unenrolled Subjects
    Iterable<EnrollmentSubjectModel> uSubjects = subjects.where(
        (subject) => !eSubjects.any((eSubject) => eSubject.id == subject.id));

    unenrolledSubjects.value = uSubjects.toList();
  }

  // Toggle enrolled subject selection
  void toggleErolledSubjectSelection(String subjectName) {
    int unselected = 0;
    int newSubjects = 0;

    for (var element in enrolledSubjects) {
      if (!element.selected) {
        unselected++;
      }
    }

    for (var element in unenrolledSubjects) {
      if (element.selected) {
        newSubjects++;
      }
    }

    var subject =
        enrolledSubjects.firstWhere((subject) => subject.name == subjectName);

    if (unselected > 1 || newSubjects > 0) {
      subject.toggleSelection();

      unselected--;
    } else {
      if (subject.selected) {
        subject.toggleSelection();

        unselected++;
      }
    }

    enrolledSubjects.refresh();

    if (newSubjects > 0 ||
        (unselected > 0 && unselected < enrolledSubjects.length)) {
      subjectsSelected.value = true;
    } else {
      subjectsSelected.value = false;
    }
  }

  // Toggle unenrolled subject selection
  void toggleUnerolledSubjectSelection(String subjectName) {
    var subject =
        unenrolledSubjects.firstWhere((subject) => subject.name == subjectName);
    subject.toggleSelection();
    unenrolledSubjects.refresh();

    int unselected = 0;
    int newSubjects = 0;

    for (var element in enrolledSubjects) {
      if (!element.selected) {
        unselected++;
      }
    }

    for (var element in unenrolledSubjects) {
      if (element.selected) {
        newSubjects++;
      }
    }

    if (newSubjects == 0 && unselected < 1) {
      for (var element in enrolledSubjects) {
        element.toggleSelection();
      }
      enrolledSubjects.refresh();
    }

    if (newSubjects > 0 ||
        (unselected > 0 && unselected < enrolledSubjects.length)) {
      subjectsSelected.value = true;
    } else {
      subjectsSelected.value = false;
    }
  }
}
