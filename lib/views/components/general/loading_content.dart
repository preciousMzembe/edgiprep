import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

Widget loadingContent(String title, String message) {
  return LayoutBuilder(builder: (context, constraints) {
    bool isTablet = DeviceUtils.isTablet(context);
    bool isSmallTablet = DeviceUtils.isSmallTablet(context);

    double titleSize = isTablet
        ? 34.sp
        : isSmallTablet
            ? 36.sp
            : 38.sp;

    double subtitleSize = isTablet
        ? 18.sp
        : isSmallTablet
            ? 20.sp
            : 22.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'icons/loading.json',
          height: 200.h,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: titleSize,
            fontWeight: FontWeight.w800,
            color: const Color.fromRGBO(52, 74, 106, 1),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: subtitleSize,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(92, 101, 120, 1),
            ),
          ),
        ),
      ],
    );
  });
}
