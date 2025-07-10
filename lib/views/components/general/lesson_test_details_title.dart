import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonTestDetailsTitle(String text, Color textColor) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleSize = isTablet
          ? 34.sp
          : isSmallTablet
              ? 36.sp
              : 38.sp;

      return Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: titleSize,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      );
    },
  );
}
