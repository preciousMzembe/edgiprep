import 'package:edgiprep/controllers/enrollment/enrollment_controller.dart';
import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/exam/user_exam.dart';
import 'package:edgiprep/db/subject/subject.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_exam_subject_option.dart';
import 'package:edgiprep/views/components/general/loading_content.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
import 'package:edgiprep/views/components/profile/profile_title.dart';
import 'package:edgiprep/views/components/settings/enroll_exam_subject_content.dart';
import 'package:edgiprep/views/components/settings/exam_nav_option.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/unenroll_exam_content.dart';
import 'package:edgiprep/views/components/settings/unenroll_exam_subject_content.dart';
import 'package:edgiprep/views/components/subjects/subjects_options_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EnrollmentSettingsExam extends StatefulWidget {
  final UserExam exam;
  const EnrollmentSettingsExam({super.key, required this.exam});

  @override
  State<EnrollmentSettingsExam> createState() => _EnrollmentSettingsExamState();
}

class _EnrollmentSettingsExamState extends State<EnrollmentSettingsExam> {
  EnrollmentController enrollmentController = Get.find<EnrollmentController>();

  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  EnrollmentSettingsController enrollmentSettingsController =
      Get.find<EnrollmentSettingsController>();

  List<String> navOptions = [
    "Enrolled",
    "Unenrolled",
    "Settings",
  ];

  bool loading = true;
  List<UserSubject> subjects = [];
  List<Subject> otherSubjects = [];

  String selectedTitle = "Enrolled";

  void changeSelected(String title) {
    setState(() {
      selectedTitle = title;
    });
  }

  Future<void> getSubjects() async {
    var data = await userEnrollmentController
        .fetchEnrolledExamSubjects(widget.exam.enrollmentId);
    var otherData = await enrollmentController.fetchNewSubjects(widget.exam.id);

    setState(() {
      subjects = data;
      otherSubjects = otherData;
      loading = false;
    });
  }

  Future<void> refreshSubjects() async {
    var data = await userEnrollmentController
        .fetchEnrolledExamSubjects(widget.exam.enrollmentId);
    var otherData = await enrollmentController.fetchNewSubjects(widget.exam.id);

    setState(() {
      subjects = data;
      otherSubjects = otherData;
    });
  }

  @override
  void initState() {
    super.initState();

    getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = DeviceUtils.isTablet(context);
    bool isSmallTablet = DeviceUtils.isSmallTablet(context);

    double iconSize = isTablet
        ? 150.h
        : isSmallTablet
            ? 150.h
            : 150.h;

    double titleSize = isTablet
        ? 26.sp
        : isSmallTablet
            ? 28.sp
            : 30.sp;

    double infoSize = isTablet
        ? 20.sp
        : isSmallTablet
            ? 22.sp
            : 24.sp;

    return LayoutBuilder(builder: (context, constraints) {
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
                  color: const Color.fromARGB(255, 184, 220, 255),
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
                      appraisalTestSubtitle("Manage exam enrollment",
                          const Color.fromARGB(255, 60, 67, 83)),
                      // navigation
                      SizedBox(
                        height: 40.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...navOptions.map(
                              (text) => ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: GestureDetector(
                                  onTap: () {
                                    changeSelected(text);
                                  },
                                  child: examNavOption(
                                    text,
                                    selectedTitle == text
                                        ? const Color.fromARGB(66, 36, 53, 78)
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Enrolled subjects
                        if (selectedTitle == "Enrolled")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child:
                                    subjectsOptionsTitle("Enrolled Subjects"),
                              ),

                              // subjetcs
                              ...subjects.map((subject) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (subjects.length > 1) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return UnenrollExamSubjectContent(
                                                onEnrolled: refreshSubjects,
                                                enrollmentId:
                                                    subject.enrollmentId,
                                                subject: subject.title,
                                              );
                                            },
                                          );
                                        } else {
                                          showSnackbar(
                                              context,
                                              "Can Not Unenroll",
                                              "This is the only subject you have.",
                                              true);
                                        }
                                      },
                                      child:
                                          enrollmentSettingsExamSubjectOption(
                                        subject.title,
                                        subject.icon,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),

                        // other subjects
                        if (selectedTitle == "Unenrolled")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: subjectsOptionsTitle("Other Subjects"),
                              ),
                              ...otherSubjects.map((subject) {
                                // ckeck if subject is already enrolled
                                bool isEnrolled = subjects.any((s) =>
                                    s.title.toLowerCase() ==
                                    subject.title.toLowerCase());
                                if (isEnrolled) {
                                  return const SizedBox();
                                }
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return EnrollExamSubjectContent(
                                              enrollmentId:
                                                  widget.exam.enrollmentId,
                                              subjectId: subject.id,
                                              subject: subject.title,
                                              onEnrolled: refreshSubjects,
                                            );
                                          },
                                        );
                                      },
                                      child:
                                          enrollmentSettingsExamSubjectOption(
                                        subject.title,
                                        subject.icon,
                                      ),
                                    ),
                                  ],
                                );
                              }),

                              // No subjects
                              if (otherSubjects.length == subjects.length)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    SvgPicture.asset(
                                      'icons/shield.svg',
                                      height: iconSize,
                                      width: iconSize,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.white, BlendMode.srcIn),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Text(
                                      "No Unenrolled Subjects",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.w800,
                                        color: const Color.fromRGBO(
                                            161, 168, 183, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50.w),
                                      child: Text(
                                        "You are currently enrolled in all available subjects. You can not enroll in any other subjects.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: infoSize,
                                          fontWeight: FontWeight.w400,
                                          color: const Color.fromRGBO(
                                              161, 168, 183, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),

                        // Unenroll exam
                        if (selectedTitle == "Settings")
                          Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                ),
                                if (userEnrollmentController.exams.length > 1)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: Text(
                                          "Unenrolling the exam will remove all exam progress. You will start over if you enroll the exam again.",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            fontSize: infoSize,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(
                                                161, 168, 183, 1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
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

                                          bool enrolled =
                                              await enrollmentSettingsController
                                                  .checkExamEnrollment(
                                                      widget.exam.id);

                                          if (!enrolled) {
                                            Get.back();
                                          }
                                        },
                                        child: normalButton(
                                          const Color.fromRGBO(254, 101, 93, 1),
                                          Colors.white,
                                          "Unenroll",
                                          16,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (userEnrollmentController.exams.length <= 1)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SvgPicture.asset(
                                        'icons/shield.svg',
                                        height: iconSize,
                                        width: iconSize,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Text(
                                        "Can Not Unenroll",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: titleSize,
                                          fontWeight: FontWeight.w800,
                                          color: const Color.fromRGBO(
                                              161, 168, 183, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w),
                                        child: Text(
                                          "You are currently enrolled in the only exam. You can not unenroll from the exam.",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            fontSize: infoSize,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(
                                                161, 168, 183, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          }),
                      ],
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
    });
  }
}
