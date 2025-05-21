import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave_loading_indicator/wave_progress.dart';

Widget homeWeeklyBox(
    double fontSize, double pieHeight, double barWidth, double progFontSize) {
  AuthController authController = Get.find<AuthController>();

  return Container(
    padding: EdgeInsets.all(30.w),
    decoration: BoxDecoration(
      color: Colors.white,
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
        Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(pieHeight),
                child: Container(
                  height: pieHeight,
                  width: pieHeight,
                  color: const Color.fromRGBO(248, 248, 250, 1),
                ),
              ),
              // pie
              WaveProgress(
                borderSize: 0,
                size: pieHeight,
                borderColor: Colors.transparent,
                foregroundWaveColor: primaryColor,
                backgroundWaveColor: homeLightBackgroundColor,
                progress: authController.user.value?.weekly ?? 0.0,
                innerPadding: 0,
              ),

              // info
              SizedBox(
                height: pieHeight,
                width: pieHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${authController.user.value != null ? (authController.user.value?.weekly ?? 0).round() : 0}%",
                      style: GoogleFonts.inter(
                        fontSize: progFontSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
