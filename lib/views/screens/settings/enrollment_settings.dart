import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_exam_option.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_subjects_title.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_subject_option.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/profile/profile_subtitle.dart';
import 'package:edgiprep/views/components/profile/profile_title.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_icon.dart';
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
  EnrollmentSettingsController enrollmentSettingsController =
      Get.find<EnrollmentSettingsController>();

  @override
  void initState() {
    super.initState();

    enrollmentSettingsController.fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // data
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    // back and profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: settingsBackButton(),
                        ),
                        settingsIcon(FontAwesomeIcons.gear),
                      ],
                    ),

                    // title and subtitle
                    SizedBox(
                      height: 30.h,
                    ),
                    profileTitle("Enrollment"),
                    profileSubtitle("Make changes to your exams and subjects"),

                    // Exams
                    SizedBox(
                      height: 40.h,
                    ),
                    Obx(() {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 30.r,
                          mainAxisSpacing: 30.r,
                          childAspectRatio: 2 / 1.4,
                        ),
                        itemCount: enrollmentSettingsController.exams.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              enrollmentSettingsController.selectExam(
                                  enrollmentSettingsController
                                      .exams[index].name);
                            },
                            child: enrollmentExamOption(
                              context,
                              enrollmentSettingsController
                                  .exams[index].selected,
                              enrollmentSettingsController.exams[index].name,
                            ),
                          );
                        },
                      );
                    }),

                    // subjects
                    SizedBox(
                      height: 40.h,
                    ),
                    enrollmentSettingsSubjectsTitle("JCE Subjects"),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...enrollmentSettingsController.subjects
                              .map((subject) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  enrollmentSettingsController
                                      .toggleSubjectSelection(subject.name);
                                },
                                child: enrollmentSubjectOption(
                                  subject.selected,
                                  subject.name,
                                  subject.icon,
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),

                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),

              // button
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: normalButton(
                  // primaryColor,
                  unselectedButtonColor,
                  const Color.fromRGBO(52, 74, 106, 1),
                  "Update",
                  20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
