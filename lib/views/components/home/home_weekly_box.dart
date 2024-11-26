import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget homeWeeklyBox(
    double fontSize, double radius, double barWidth, double progFontSize) {
  AuthController authController = Get.find<AuthController>();

  return Container(
    padding: EdgeInsets.all(30.w),
    decoration: BoxDecoration(
      color: homeLightBackgroundColor,
      borderRadius: BorderRadius.circular(22.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Weekly \nPerformance",
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(52, 74, 106, 1),
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        Obx(() {
          return CircularPercentIndicator(
            radius: radius,
            percent: authController.user.value != null
                ? authController.user.value!.weeklyProgress / 100
                : 0,
            progressColor: primaryColor,
            lineWidth: barWidth,
            animationDuration: 2000,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: const Color.fromRGBO(169, 210, 251, 1),
            startAngle: 0,
            animation: true,
            center: Text(
              "${authController.user.value != null ? (authController.user.value!.weeklyProgress).toStringAsFixed(0) : 0}%",
              style: GoogleFonts.inter(
                color: const Color.fromRGBO(52, 74, 106, 1),
                fontSize: progFontSize,
                fontWeight: FontWeight.w900,
              ),
            ),
          );
        }),
      ],
    ),
  );
}
