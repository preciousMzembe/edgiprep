import 'dart:ui';

import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EnrollExamSubjectContent extends StatefulWidget {
  final String enrollmentId;
  final String subjectId;
  final String subject;
  final Future<void> Function() onEnrolled;
  const EnrollExamSubjectContent(
      {super.key,
      required this.subjectId,
      required this.enrollmentId,
      required this.subject,
      required this.onEnrolled});

  @override
  State<EnrollExamSubjectContent> createState() =>
      _EnrollExamSubjectContentState();
}

class _EnrollExamSubjectContentState extends State<EnrollExamSubjectContent> {
  EnrollmentSettingsController enrollmentSettingsController =
      Get.find<EnrollmentSettingsController>();

  bool loading = false;

  void toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double titleFontSize = isTablet
            ? 32.sp
            : isSmallTablet
                ? 34.sp
                : 36.sp;

        double subtitleFontSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        double height = isTablet
            ? 80.sp
            : isSmallTablet
                ? 82.h
                : 84.h;

        double fontSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 24.sp;

        double iconHeight = isTablet
            ? 66.h
            : isSmallTablet
                ? 68.h
                : 70.h;

        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                ),
              ),
            ),
            Center(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      // image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'icons/happy.svg',
                            height: 155.r,
                            width: 155.r,
                          ),
                        ],
                      ),
                      // title
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        "You Want to Enroll \n ${widget.subject}?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(52, 74, 106, 1),
                        ),
                      ),

                      // text
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Enrolling in the subject will add the subject to your exam. You can always remove it later.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(89, 89, 89, 1),
                        ),
                      ),

                      // button
                      SizedBox(
                        height: 40.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            height: height,
                            color: const Color.fromRGBO(236, 239, 245, 1),
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: Center(
                              child: Text(
                                "No, Cancel",
                                style: GoogleFonts.inter(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(52, 74, 106, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              toggleLoading();

                              await enrollmentSettingsController.enrollSubject(
                                  widget.enrollmentId, widget.subjectId);

                              await widget.onEnrolled();

                              if (mounted) {
                                Get.back();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Container(
                                height: height,
                                color: primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: Center(
                                  child: Text(
                                    "Yes, Enroll",
                                    style: GoogleFonts.inter(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // loading
                          if (loading)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Container(
                                height: height,
                                color: const Color.fromRGBO(236, 239, 245, 1),
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: Center(
                                  child: Lottie.asset(
                                    'icons/loading.json',
                                    height: iconHeight,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
