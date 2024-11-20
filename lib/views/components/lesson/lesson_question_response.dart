import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonQuestionResponse(String text, bool selected) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);
      double fontSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      return Container(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            width: 2.r,
            color:
                selected ? const Color.fromRGBO(73, 161, 249, 1) : Colors.white,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: selected
                ? const Color.fromRGBO(73, 161, 249, 1)
                : const Color.fromRGBO(92, 101, 120, 1),
          ),
        ),
      );
    },
  );
}
