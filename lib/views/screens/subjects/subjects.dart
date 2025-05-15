import 'dart:ui';

import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/normal_input.dart';
import 'package:edgiprep/views/components/subjects/enroll_subjects_content.dart';
import 'package:edgiprep/views/components/subjects/subjects_add_subject.dart';
import 'package:edgiprep/views/components/subjects/subjects_subject_box.dart';
import 'package:edgiprep/views/screens/subjects/subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Subjects extends StatelessWidget {
  final Function refreshData;
  const Subjects({super.key, required this.refreshData});

  @override
  Widget build(BuildContext context) {
    EnrollmentSettingsController enrollmentSettingsController =
        Get.find<EnrollmentSettingsController>();

    UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();

    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Obx(() {
            return LiquidPullToRefresh(
              onRefresh: () async {
                await refreshData();
              },
              color: appbarColor,
              backgroundColor: Colors.white,
              animSpeedFactor: 2,
              showChildOpacityTransition: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    const NormalInput(
                      label: "Search Subjects",
                      type: TextInputType.text,
                      isPassword: false,
                      icon: FontAwesomeIcons.magnifyingGlass,
                      radius: 16,
                    ),

                    // Subjects
                    SizedBox(
                      height: 40.h,
                    ),
                    ...userEnrollmentController.subjects.map((subject) {
                      double percent = 0;

                      if (subject.numberOfTopics > 0) {
                        percent =
                            subject.numberOfTopicsDone / subject.numberOfTopics;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => Subject(
                                    subject: subject,
                                  ));
                            },
                            child: subjectsSubjectBox(
                              getFadeColorFromString(subject.color),
                              subject.image,
                              subject.title,
                              subject.currentTopic,
                              "${subject.numberOfTopicsDone} of ${subject.numberOfTopics} Topics",
                              percent,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      );
                    }),

                    // add subject
                    if (enrollmentSettingsController
                        .unenrolledSubjects.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                builder: (BuildContext context) =>
                                    BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: EnrollSubjectsContent(),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(0),
                                  ),
                                ),
                              );
                            },
                            child: subjectsAddSubject(),
                          ),
                        ],
                      ),

                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
