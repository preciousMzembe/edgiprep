import 'dart:ui';

import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_exam_option.dart';
import 'package:edgiprep/views/components/general/normal_svg_button.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_enroll_exam_content.dart';
import 'package:edgiprep/views/components/settings/settings_icon.dart';
import 'package:edgiprep/views/components/settings/settings_title.dart';
import 'package:edgiprep/views/components/subjects/subjects_options_title.dart';
import 'package:edgiprep/views/screens/settings/enrollment_settings_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EnrollmentSettings extends StatefulWidget {
  const EnrollmentSettings({super.key});

  @override
  State<EnrollmentSettings> createState() => _EnrollmentSettingsState();
}

class _EnrollmentSettingsState extends State<EnrollmentSettings> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: ListView(
            children: [
              // top
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 30.h,
                ),
                color: const Color.fromRGBO(215, 235, 255, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // settings
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: settingsBackButton(),
                            ),
                            settingsTitle("Enrollment"),
                          ],
                        ),
                        settingsIcon(FontAwesomeIcons.gear),
                      ],
                    ),
                  ],
                ),
              ),

              // options
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Obx(
                  () {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: subjectsOptionsTitle("Enrolled Exams"),
                        ),

                        // exams
                        ...userEnrollmentController.exams.map((exam) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => EnrollmentSettingsExam(
                                        exam: exam,
                                      ));
                                },
                                child: enrollmentSettingsExamOption(exam.title),
                              ),
                            ],
                          );
                        }),

                        // add if other exams available
                        if (userEnrollmentController.allExams.length >
                            userEnrollmentController.exams.length)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 30.h,
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
                                      filter: ImageFilter.blur(
                                          sigmaX: 3, sigmaY: 3),
                                      child: SettingsEnrollExamContent(),
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(0),
                                      ),
                                    ),
                                  );
                                },
                                child: normalSvgButton(
                                  primaryColor,
                                  Colors.white,
                                  "Enroll Exam",
                                  20,
                                  "add.svg",
                                ),
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
