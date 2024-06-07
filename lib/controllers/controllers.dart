import 'package:edgiprep/controllers/current_quiz_controller.dart';
import 'package:edgiprep/controllers/nav_controller.dart';
import 'package:get/get.dart';

class Controllers extends Bindings {
  @override
  void dependencies() {
    Get.put<NavController>(NavController());
    Get.put<CurrentQuizController>(CurrentQuizController());
  }
}
