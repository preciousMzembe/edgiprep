import 'package:edgiprep/db/subject/subject.dart';
import 'package:edgiprep/models/exams/enrollment_exam_model.dart';
import 'package:edgiprep/models/subjects/enrollment_subject_model.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:get/get.dart';

class EnrollmentController extends GetxController {
  final EnrollmentService enrollmentService = Get.find<EnrollmentService>();

  RxBool examSelected = false.obs;
  RxList<EnrollmentExamModel> exams = <EnrollmentExamModel>[].obs;
  RxList<EnrollmentSubjectModel> subjects = <EnrollmentSubjectModel>[].obs;
  RxBool subjectsSelected = false.obs;

  RxString enrolledExamId = "".obs;

  @override
  void onInit() {
    super.onInit();

    // listen to change in exams fetch
    ever(enrollmentService.doneFetchingExams, (_) {
      fetchExams();
    });
  }

  // Fetch exams
  Future<void> fetchExams() async {
    exams.value = await enrollmentService.getExams();
    if (exams.isNotEmpty) {
      selectExam(exams.first.name);
    }
  }

  // Select exam
  void selectExam(String examName) {
    for (var exam in exams) {
      exam.selected = exam.name == examName;
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

    subjects.refresh();
  }

  Future<List<Subject>> fetchNewSubjects(String examId) async {
    List<Subject> subjects = await enrollmentService.getExamSubjects(examId);

    return subjects;
  }

  // Toggle subject selection
  void toggleSubjectSelection(String subjectName) {
    var subject = subjects.firstWhere((subject) => subject.name == subjectName);
    subject.toggleSelection();
    subjectsSelected.value = subjects.any((subject) => subject.selected);
    subjects.refresh();
  }

  // Enroll Exam and Subjects
  Future<bool> enroll() async {
    EnrollmentExamModel selectedExam =
        exams.firstWhere((exam) => exam.selected);

    List<String> selectedSubjects = [];
    for (var subject in subjects) {
      if (subject.selected) {
        selectedSubjects.add(subject.id);
      }
    }

    bool done =
        await enrollmentService.enroll(selectedExam.id, selectedSubjects);

    if (done) {
      enrolledExamId.value = selectedExam.id;
      enrolledExamId.refresh();
    } else {
      enrolledExamId.value = "";
    }

    return done;
  }
}
