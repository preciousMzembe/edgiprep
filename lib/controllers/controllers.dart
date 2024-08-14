import 'package:edgiprep/controllers/add_exam_controller.dart';
import 'package:edgiprep/controllers/auth_controller.dart';
import 'package:edgiprep/controllers/current_challange_controller.dart';
import 'package:edgiprep/controllers/current_lesson_controller.dart';
import 'package:edgiprep/controllers/current_mock_controller.dart';
import 'package:edgiprep/controllers/current_quiz_controller.dart';
import 'package:edgiprep/controllers/nav_controller.dart';
import 'package:edgiprep/controllers/papers_controller.dart';
import 'package:edgiprep/controllers/subjects_settings_controller.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:get/get.dart';

class Controllers extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
    Get.put<AuthController>(AuthController());
    Get.put<NavController>(NavController());
    Get.put<CurrentQuizController>(CurrentQuizController());
    Get.put<CurrentChallangeController>(CurrentChallangeController());
    Get.put<CurrentLessonController>(CurrentLessonController());
    Get.put<CurrentMockController>(CurrentMockController());
    Get.put<AddExamController>(AddExamController());
    Get.put<SubjectsSettingsController>(SubjectsSettingsController());
    Get.put<PapersController>(PapersController());
  }
}
