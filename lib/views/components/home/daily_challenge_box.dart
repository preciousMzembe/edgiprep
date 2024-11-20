import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/home/challenge_image.dart';
import 'package:edgiprep/views/components/home/home_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget dailyChallengeBox() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleSize = isTablet
          ? 24.sp
          : isSmallTablet
              ? 26.sp
              : 28.sp;

      double subtitleSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return Container(
        padding: EdgeInsets.all(40.w),
        decoration: BoxDecoration(
          color: Colors.white,
          // color: homeLightBackgroundColor,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          children: [
            // details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Daily Challenge",
                    style: GoogleFonts.inter(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(52, 74, 106, 1),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Test your knowledge by getting started with Daily challenge.",
                    style: GoogleFonts.inter(
                      fontSize: subtitleSize,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(111, 137, 169, 1),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      homeRoundedButton(
                          primaryColor, Colors.white, "Start Now", 100),
                    ],
                  ),
                ],
              ),
            ),
            challengeImage(),
          ],
        ),
      );
    },
  );
}
