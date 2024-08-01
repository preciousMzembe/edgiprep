import 'package:get/get.dart';
// import 'package:dio/dio.dart';

class AddExamController extends GetxController {
  // final Dio _dio = Dio();

  // Preferences variables
  final RxList _exams = [].obs;
  final RxString _userExam = "".obs;

  final RxList _subjects = [].obs;
  final RxList _userSubjects = [].obs;

  List get exams => _exams;
  String get userExam => _userExam.value;
  List get subjects => _subjects;
  List get userSubjects => _userSubjects;

  Future<void> setExams() async {
    // TODO: get exams from internet
    // const String url = 'https://api.example.com/exams';
    // try {
    //   final response = await _dio.get(url);
    //   if (response.statusCode == 200) {
    //     response.data;
    //   } else {
    //     print('Failed to load exams');
    //   }
    // } catch (e) {
    //   print('Failed to load exams: $e');
    // }

    _exams.value = [
      "JCE",
      "MSCE",
      "PSLCE",
    ];
  }

  Future<void> setSubjects() async {
    // TODO: get subjects from internet based on selected exam
    // const String url = 'https://api.example.com/subjects';
    // try {
    //   final response = await _dio.get(url);
    //   if (response.statusCode == 200) {
    //     response.data;
    //   } else {
    //     print('Failed to load subjects');
    //   }
    // } catch (e) {
    //   print('Failed to load subjects: $e');
    // }
    _subjects.value = [
      ["Biology", "biology.jpg"],
      ["History", "history.jpg"],
      ["Geography", "geography.jpg"],
      ["Chemistry", "science.jpg"],
      ["Agriculture", "agriculture.jpg"],
    ];
  }

  void setUserExam(String exam) {
    _userExam.value = exam;
  }

  void addRemoveUserSubjects(List subject) {
    if (!userSubjects.contains(subject)) {
      _userSubjects.add(subject);
    } else {
      _userSubjects.remove(subject);
    }
  }

  // reset controller
  void resetController() {
    _userExam.value = "";
    _userSubjects.value = [];
  }

  // initialize data
  @override
  void onInit() {
    super.onInit();

    // Auth

    // Preferences
    setExams();
    // TODO: set subjects after selecting an exam
    setSubjects();
  }
}
