import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget topicLessonsNumber(String name, Color color) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double lessonsFontSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      return Text(
        name,
        style: GoogleFonts.inter(
          fontSize: lessonsFontSize,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      );
    },
  );
}
