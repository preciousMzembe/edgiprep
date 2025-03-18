import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/views/screens/dashboard/dashboard.dart';
import 'package:edgiprep/views/screens/enrollment/enrollment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();
    return Scaffold(
      // dashboard or enrollment
      body: Obx(() {
        return userEnrollmentController.exams.isEmpty
            ? const Enrollment()
            : const Dashboard();
      }),
    );
  }
}
