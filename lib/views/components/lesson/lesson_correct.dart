import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonCorrect() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 46.sp
          : isSmallTablet
              ? 48.sp
              : 50.sp;
      double subtitleFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: const Color.fromRGBO(195, 241, 205, 1),
              padding: EdgeInsets.symmetric(
                horizontal: 50.w,
                vertical: 50.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: SvgPicture.asset(
                          'icons/happy.svg',
                          height: 130.r,
                          width: 130.r,
                        ),
                      ),
                    ],
                  ),

                  // title
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Great Work",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(102, 203, 124, 1),
                    ),
                  ),

                  // subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Text(
                      "Correct answer! You've earned 1 XP. Keep it up!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(92, 101, 120, 1),
                      ),
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
                    child: normalButton(
                      const Color.fromRGBO(102, 203, 124, 1),
                      Colors.white,
                      "Continue",
                      100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
