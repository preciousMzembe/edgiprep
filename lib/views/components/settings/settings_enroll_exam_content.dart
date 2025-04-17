import 'package:edgiprep/controllers/enrollment/enrollment_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_exam_option.dart';
import 'package:edgiprep/views/screens/enrollment/subjects_enrollment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsEnrollExamContent extends StatefulWidget {
  const SettingsEnrollExamContent({super.key});

  @override
  State<SettingsEnrollExamContent> createState() =>
      _SettingsEnrollExamContentState();
}

class _SettingsEnrollExamContentState extends State<SettingsEnrollExamContent> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();
  EnrollmentController enrollmentController = Get.find<EnrollmentController>();

  @override
  void initState() {
    super.initState();

    userEnrollmentController.fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 36.sp
          : isSmallTablet
              ? 38.sp
              : 40.sp;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: backgroundColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              "Pick the Exam You Want to Enroll",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(17, 25, 37, 1),
                              ),
                            ),
                          ),
                          Obx(() {
                            return SizedBox(
                              height: 500.h,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ...userEnrollmentController.allExams
                                        .map((exam) {
                                      return exam.enrollmentId == ""
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 30.h),
                                              child: GestureDetector(
                                                onTap: () {
                                                  enrollmentController
                                                      .selectExam(exam.name);
                                                  Navigator.pop(context);
                                                  Get.to(
                                                      () => SubjectsEnrollment(
                                                            settings: true,
                                                          ));
                                                },
                                                child:
                                                    enrollmentSettingsExamOption(
                                                        exam.name),
                                              ),
                                            )
                                          : Container();
                                    }),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
