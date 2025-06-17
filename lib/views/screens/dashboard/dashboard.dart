import 'dart:ui';

import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/controllers/navigation/navController.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/services/auth/auth_service.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/dashboard/app_locked.dart';
import 'package:edgiprep/views/components/dashboard/navigation_bar.dart';
import 'package:edgiprep/views/components/dashboard/update_content.dart';
import 'package:edgiprep/views/screens/appraisal/appraisal.dart';
import 'package:edgiprep/views/screens/dashboard/home.dart';
import 'package:edgiprep/views/screens/settings/settings.dart';
import 'package:edgiprep/views/screens/subjects/subject.dart';
import 'package:edgiprep/views/screens/subjects/subjects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NavController navController = Get.find<NavController>();
  final PageController pageController = PageController(initialPage: 0);

  AuthService authService = Get.find<AuthService>();
  EnrollmentService enrollmentService = Get.find<EnrollmentService>();

  UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();

  AuthController authController = Get.find<AuthController>();

  void changeNavIndex(int index) {
    navController.changePageIndex(index);
    pageController.jumpToPage(index);
  }

  void goToSubjects() {
    navController.changePageIndex(1);
    pageController.jumpToPage(1);
  }

  void openSubject(UserSubject subject) {
    Get.to(
      () => Subject(
        subject: subject,
      ),
    );
  }

  void refreshData() async {
    await authService.getUserServerData();
    await userEnrollmentService.getUserServerExams();

    enrollmentService.restartFetch();
  }

  // Check for update
  bool isUpdateAvailable = false;

  void checkForUpdate() async {
    final newVersion = NewVersionPlus(
      androidId: androidId,
    );

    try {
      final status = await newVersion.getVersionStatus();

      if (status != null && status.canUpdate) {
        setState(() {
          isUpdateAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        isUpdateAvailable = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, others) {
        if (navController.pageIndex.value == 0) {
          SystemNavigator.pop();
          return;
        } else {
          navController.changePageIndex(0);
          pageController.jumpToPage(0);
        }
      },
      child: Scaffold(
        // body
        body: Stack(
          children: [
            // Body
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                navController.changePageIndex(index);
              },
              children: [
                Home(
                  refreshData: refreshData,
                  toSubjects: goToSubjects,
                  toSubject: openSubject,
                ),
                Subjects(
                  refreshData: refreshData,
                ),
                Appraisal(
                  refreshData: refreshData,
                ),
                Settings(
                  refreshData: refreshData,
                ),
              ],
            ),

            // Update Banner
            if (isUpdateAvailable && !authController.isLocked.value)
              SafeArea(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    child: updateContent(),
                  ),
                ),
              ),

            // App Locked
            if (authController.isLocked.value) appLocked(),
          ],
        ),

        // navigation
        bottomNavigationBar:
            !isUpdateAvailable && !authController.isLocked.value
                ? navigationBar(changeNavIndex)
                : null,
      ),
    );
  }
}
