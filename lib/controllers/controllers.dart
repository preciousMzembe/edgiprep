import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/controllers/challenge/challenge_controller.dart';
import 'package:edgiprep/controllers/enrollment/enrollment_controller.dart';
import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/controllers/lesson/lesson_controller.dart';
import 'package:edgiprep/controllers/mock/mock_controller.dart';
import 'package:edgiprep/controllers/navigation/navController.dart';
import 'package:edgiprep/controllers/notification/notification_controller.dart';
import 'package:edgiprep/controllers/past_paper/paper_controller.dart';
import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/challenge/challenge_service.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:edgiprep/services/lesson/lesson_service.dart';
import 'package:edgiprep/services/mock/mock_service.dart';
import 'package:edgiprep/services/paper/paper_service.dart';
import 'package:edgiprep/services/notification/notification_service.dart';
import 'package:edgiprep/services/quiz/quiz_service.dart';
import 'package:edgiprep/services/search/search_service.dart';
import 'package:edgiprep/services/stats/stats_service.dart';
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
    Get.put<LessonService>(LessonService());
    Get.put<QuizService>(QuizService());
    Get.put<ChallengeService>(ChallengeService());
    Get.put<PaperService>(PaperService());
    Get.put<MockService>(MockService());
    Get.put<StatsService>(StatsService());
    Get.put<SearchService>(SearchService());

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
