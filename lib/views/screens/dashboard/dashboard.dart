import 'package:edgiprep/controllers/navigation/navController.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/dashboard/navigation_bar.dart';
import 'package:edgiprep/views/screens/appraisal/appraisal.dart';
import 'package:edgiprep/views/screens/dashboard/home.dart';
import 'package:edgiprep/views/screens/settings/settings.dart';
import 'package:edgiprep/views/screens/subjects/subject.dart';
import 'package:edgiprep/views/screens/subjects/subjects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NavController navController = Get.find<NavController>();
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: primaryColor,
        // body
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            navController.changePageIndex(index);
          },
          children: [
            Home(
              toSubjects: goToSubjects,
              toSubject: openSubject,
            ),
            const Subjects(),
            const Appraisal(),
            const Settings(),
          ],
        ),

        // navigation
        bottomNavigationBar: navigationBar(changeNavIndex),
      ),
    );
  }
}
