import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/views/components/auth/auth_back.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_rich_text.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_subject_option.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_subtitle.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_title.dart';
import 'package:edgiprep/views/components/general/button_loading.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/controllers/enrollment/enrollment_controller.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsEnrollment extends StatefulWidget {
  final bool settings;
  const SubjectsEnrollment({
    super.key,
    this.settings = false,
  });

  @override
  State<SubjectsEnrollment> createState() => _SubjectsEnrollmentState();
}

class _SubjectsEnrollmentState extends State<SubjectsEnrollment> {
  bool loading = false;

  void toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    EnrollmentController enrollmentController =
        Get.find<EnrollmentController>();

    final UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();

    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // back
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: authBack(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),

                // title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child:
                      enrollmentTitle("Pick the Subjects You Want to Focus On"),
                ),

                // subtitle
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: enrollmentSubtitle(
                    "Choose the subjects you're preparing for now. You can always add more later!",
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                Expanded(
                  child: ListView(
                    children: [
                      // subjects options
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:
                              enrollmentController.subjects.map((subject) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  enrollmentController
                                      .toggleSubjectSelection(subject.name);
                                },
                                child: enrollmentSubjectOption(
                                  subject.selected,
                                  subject.name,
                                  subject.icon,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),

                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  ),
                ),

                // not sure text
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: enrollmentRichText(
                    "Not sure which one to select? ",
                    [
                      TextSpan(
                        text: "Learn more ",
                        style: GoogleFonts.inter(
                          color: primaryColor,
                        ),
                      ),
                      const TextSpan(text: "about each subject. "),
                    ],
                  ),
                ),

                // continue
                SizedBox(
                  height: 35.h,
                ),
                Stack(
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () async {
                          if (enrollmentController.subjectsSelected.value) {
                            toggleLoading();

                            bool done = await enrollmentController.enroll();

                            if (done) {
                              Get.back();

                              if (widget.settings) {
                                // Switch
                                if (enrollmentController.enrolledExamId.value !=
                                    "") {
                                  await userEnrollmentController.switchExam(
                                      enrollmentController
                                          .enrolledExamId.value);
                                }
                              }
                            } else {
                              showSnackbar(
                                  context,
                                  "Something Went Wrong",
                                  "There was a problem finishing your enrollment",
                                  true);
                            }
                          }
                        },
                        child: normalButton(
                          enrollmentController.subjectsSelected.value
                              ? primaryColor
                              : unselectedButtonColor,
                          enrollmentController.subjectsSelected.value
                              ? Colors.white
                              : const Color.fromRGBO(52, 74, 106, 1),
                          "Continue",
                          16,
                        ),
                      );
                    }),

                    // loading
                    if (loading) buttonLoading(unselectedButtonColor, 16),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
