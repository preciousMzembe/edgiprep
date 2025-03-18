import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/controllers/challenge/challenge_controller.dart';
import 'package:edgiprep/controllers/enrollment/enrollment_controller.dart';
import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/controllers/lesson/lesson_controller.dart';
import 'package:edgiprep/controllers/mock/mock_controller.dart';
import 'package:edgiprep/controllers/navigation/navController.dart';
import 'package:edgiprep/controllers/notification/notification_controller.dart';
import 'package:edgiprep/controllers/past%20paper/paper_controller.dart';
import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/config/config_Service.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:edgiprep/services/notification/notification_service.dart';
import 'package:edgiprep/services/quiz/quiz_service.dart';
import 'package:get/get.dart';

class Controllers extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put<ConfigService>(ConfigService());
    Get.put<AuthService>(AuthService());
    Get.put<NotificationService>(NotificationService());
    Get.put<EnrollmentService>(EnrollmentService());
    Get.put<UserEnrollmentService>(UserEnrollmentService());
    Get.put<QuizService>(QuizService());

    // Controllers
    Get.put<NavController>(NavController());
    Get.put<AuthController>(AuthController());
    Get.put<NotificationController>(NotificationController());
    Get.put<EnrollmentController>(EnrollmentController());
    Get.put<UserEnrollmentController>(UserEnrollmentController());
    Get.put<LessonController>(LessonController());
    Get.put<QuizController>(QuizController());
    Get.put<PaperController>(PaperController());
    Get.put<MockController>(MockController());
    Get.put<ChallengeController>(ChallengeController());
    Get.put<EnrollmentSettingsController>(EnrollmentSettingsController());
  }
}
