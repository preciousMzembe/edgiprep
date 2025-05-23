import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget normalButton(
  Color background,
  Color textColor,
  String text,
  double radius,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double height = isTablet
          ? 80.h
          : isSmallTablet
              ? 82.h
              : 84.h;

      double fontSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      return ClipRRect(
        borderRadius: BorderRadius.circular(radius.r),
        child: Container(
          height: height,
          color: background,
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
        ),
      );
    },
  );
}
