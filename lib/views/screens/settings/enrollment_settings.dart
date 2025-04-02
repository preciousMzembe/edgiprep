import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_exam_option.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_subject_option.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_subjects_title.dart';
import 'package:edgiprep/views/components/general/button_loading.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
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

  bool loading = false;

  void toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

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
                    profileSubtitle("Make changes to your subjects"),

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
                                      .exams[index].title);
                            },
                            child: enrollmentExamOption(
                              context,
                              enrollmentSettingsController
                                  .exams[index].selected,
                              enrollmentSettingsController.exams[index].title,
                            ),
                          );
                        },
                      );
                    }),

                    // enrolled subjects
                    SizedBox(
                      height: 40.h,
                    ),
                    enrollmentSettingsSubjectsTitle("Your Subjects"),
                    profileSubtitle("Select subjects to unenroll"),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...enrollmentSettingsController.enrolledSubjects
                              .map((subject) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  enrollmentSettingsController
                                      .toggleErolledSubjectSelection(
                                          subject.name);
                                },
                                child: enrollmentSettingsSubjectOption(
                                  subject.selected,
                                  subject.name,
                                  subject.icon,
                                  true,
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),

                    // unenrolled subjects
                    if (enrollmentSettingsController
                        .unenrolledSubjects.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          enrollmentSettingsSubjectsTitle("Other Subjects"),
                          profileSubtitle("Select subjects to enroll"),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...enrollmentSettingsController.unenrolledSubjects
                              .map((subject) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  enrollmentSettingsController
                                      .toggleUnerolledSubjectSelection(
                                          subject.name);
                                },
                                child: enrollmentSettingsSubjectOption(
                                  subject.selected,
                                  subject.name,
                                  subject.icon,
                                  false,
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),

                    profileSubtitle(
                        "You must be enrolled in at least one subject to continue. Zero enrolled subjects is not allowed."),

                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),

              // button
              Obx(() {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (enrollmentSettingsController
                            .subjectsSelected.value) {
                          toggleLoading();

                          bool done = await enrollmentSettingsController
                              .updateSubjects();

                          if (!done) {
                            showSnackbar(
                                context,
                                "Something Went Wrong",
                                "There was a problem updating your subjects.",
                                true);
                          }

                          toggleLoading();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: normalButton(
                          // primaryColor,
                          enrollmentSettingsController.subjectsSelected.value
                              ? primaryColor
                              : unselectedButtonColor,
                          enrollmentSettingsController.subjectsSelected.value
                              ? Colors.white
                              : const Color.fromRGBO(52, 74, 106, 1),
                          "Update",
                          20,
                        ),
                      ),
                    ),

                    // loading
                    if (loading)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: buttonLoading(unselectedButtonColor, 16),
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
