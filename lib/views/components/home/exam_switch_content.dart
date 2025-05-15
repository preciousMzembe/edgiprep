import 'dart:ui';

import 'package:edgiprep/controllers/enrollment/enrollment_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/models/exams/settings_exam_model.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/settings/settings_icon.dart';
import 'package:edgiprep/views/screens/enrollment/subjects_enrollment.dart';
import 'package:edgiprep/views/screens/settings/enrollment_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ExamSwitchContent extends StatefulWidget {
  const ExamSwitchContent({super.key});

  @override
  State<ExamSwitchContent> createState() => _ExamSwitchContentState();
}

class _ExamSwitchContentState extends State<ExamSwitchContent> {
  final UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  final EnrollmentController enrollmentController =
      Get.find<EnrollmentController>();

  final RxBool loading = false.obs;
  final RxString selectedExamId = ''.obs;

  void selectExam(SettingsExamModel exam) async {
    setState(() {
      selectedExamId.value = exam.id;
      loading.value = true;
    });

    // return;

    if (exam.enrollmentId.isNotEmpty) {
      await userEnrollmentController.switchExam(exam.id);

      setState(() {
        loading.value = false;
        selectedExamId.value = "";
      });
      Get.back();
    } else {
      // enroll
      enrollmentController.selectExam(exam.name);

      setState(() {
        loading.value = false;
        selectedExamId.value = "";
      });
      Get.back();

      Get.to(() => SubjectsEnrollment(
            settings: true,
          ));
    }
  }

  @override
  void initState() {
    super.initState();

    userEnrollmentController.fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double examSize = isTablet
            ? 16.sp
            : isSmallTablet
                ? 18.sp
                : 20.sp;

        double mainIconSize = isTablet
            ? 14.sp
            : isSmallTablet
                ? 16.sp
                : 18.sp;

        double buttonHeight = isTablet
            ? 70.sp
            : isSmallTablet
                ? 60.h
                : 50.h;

        double fontSize = isTablet
            ? 32.sp
            : isSmallTablet
                ? 34.sp
                : 36.sp;

        double examFontSize = isTablet
            ? 24.sp
            : isSmallTablet
                ? 26.sp
                : 28.sp;

        double height = isTablet
            ? 36.r
            : isSmallTablet
                ? 38.r
                : 40.r;

        double iconSize = isTablet
            ? 16.r
            : isSmallTablet
                ? 18.r
                : 20.r;

        double loadingIconHeight = isTablet
            ? 50.h
            : isSmallTablet
                ? 60.h
                : 70.h;

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 30.h,
                          ),
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Switch Exam",
                                        style: GoogleFonts.inter(
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.w700,
                                          color: const Color.fromRGBO(
                                              52, 74, 106, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Get.to(() => EnrollmentSettings());
                                        },
                                        child:
                                            settingsIcon(FontAwesomeIcons.gear),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                ...userEnrollmentController.allExams.map(
                                  (exam) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40.w,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: GestureDetector(
                                        onTap: () {
                                          selectExam(exam);
                                        },
                                        child: Container(
                                          color: exam.selected
                                              ? const Color.fromRGBO(
                                                  202, 228, 253, 1)
                                              : Colors.transparent,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 35.w,
                                            vertical: 8.h,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // indicator
                                              Container(
                                                height: height,
                                                width: height,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.r),
                                                  border: Border.all(
                                                    width: 3.r,
                                                    color: exam.selected
                                                        ? const Color.fromRGBO(
                                                            35, 131, 226, 1)
                                                        : const Color.fromRGBO(
                                                            214, 220, 233, 1),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: IconTheme(
                                                      data: IconThemeData(
                                                        opacity: 1.0,
                                                      ),
                                                      child: Icon(
                                                        FontAwesomeIcons.check,
                                                        size: iconSize,
                                                        color: exam.selected
                                                            ? const Color
                                                                .fromRGBO(
                                                                35, 131, 226, 1)
                                                            : Colors
                                                                .transparent,
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),

                                              // Exam
                                              Expanded(
                                                child: Text(
                                                  exam.name,
                                                  style: GoogleFonts.inter(
                                                    color: exam.selected
                                                        ? const Color.fromRGBO(
                                                            35, 131, 226, 1)
                                                        : const Color.fromRGBO(
                                                            52, 74, 106, 1),
                                                    fontSize: examFontSize,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),

                                              // Loading
                                              if (exam.id != selectedExamId.value)
                                                SizedBox(
                                                  height: loadingIconHeight,
                                                ),
                                              if (loading.value &&
                                                  exam.id == selectedExamId.value)
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Container(
                                                          child: Lottie.asset(
                                                            'icons/loading.json',
                                                            height:
                                                                loadingIconHeight,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80.h,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              color: const Color.fromRGBO(223, 228, 237, 1),
              padding: EdgeInsets.symmetric(horizontal: 14.h),
              height: buttonHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    userEnrollmentController.activeExam.value.title,
                    style: GoogleFonts.inter(
                      fontSize: examSize,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(52, 74, 106, 1),
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  SvgPicture.asset(
                    'icons/bars.svg',
                    height: mainIconSize,
                    width: mainIconSize,
                    colorFilter: ColorFilter.mode(
                        Color.fromRGBO(52, 74, 106, 1), BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
