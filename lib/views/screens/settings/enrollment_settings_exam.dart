import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_exam_subject_option.dart';
import 'package:edgiprep/views/components/general/loading_content.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/profile/profile_title.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_icon.dart';
import 'package:edgiprep/views/components/settings/unenroll_exam_content.dart';
import 'package:edgiprep/views/components/subjects/subjects_options_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EnrollmentSettingsExam extends StatefulWidget {
  final UserExam exam;
  const EnrollmentSettingsExam({super.key, required this.exam});

  @override
  State<EnrollmentSettingsExam> createState() => _EnrollmentSettingsExamState();
}

class _EnrollmentSettingsExamState extends State<EnrollmentSettingsExam> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  EnrollmentSettingsController enrollmentSettingsController =
      Get.find<EnrollmentSettingsController>();

  bool loading = true;
  List<UserSubject> subjects = [];

  Future<void> getSubjects() async {
    var data = await userEnrollmentController
        .fetchExamSubjects(widget.exam.enrollmentId);

    setState(() {
      subjects = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getSubjects();
  }

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
                          ],
                        ),
                        settingsIcon(FontAwesomeIcons.gear),
                      ],
                    ),
                    // title and subtitle
                    SizedBox(
                      height: 30.h,
                    ),
                    profileTitle(widget.exam.title),
                    SizedBox(
                      height: 2.h,
                    ),
                    appraisalTestSubtitle("Manage exam enrollment"),
                  ],
                ),
              ),

              // options
              SizedBox(
                height: 40.h,
              ),
              // Loading
              if (loading)
                loadingContent("Getting Your Subjects",
                    "Be patient while we get your enrolled subjects."),
              if (!loading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: subjectsOptionsTitle("Enrolled Subjects"),
                        ),

                        // subjetcs
                        ...subjects.map((subject) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              enrollmentSettingsExamSubjectOption(
                                  subject.title, subject.icon),
                            ],
                          );
                        }),

                        SizedBox(
                          height: 30.h,
                        ),
                        if (userEnrollmentController.exams.length > 1)
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return UnenrollExamContent(
                                    exam: widget.exam,
                                  );
                                },
                              );

                              bool enrolled = await enrollmentSettingsController
                                  .checkExamEnrollment(widget.exam.id);

                              if (!enrolled) {
                                Navigator.pop(context);
                              }
                            },
                            child: normalButton(
                              const Color.fromRGBO(255, 99, 135, 1),
                              Colors.white,
                              "Unenroll Exam",
                              20,
                            ),
                          ),
                      ],
                    );
                  }),
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
