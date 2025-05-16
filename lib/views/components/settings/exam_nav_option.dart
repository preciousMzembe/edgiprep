import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget examNavOption(String text, Color background) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double height = isTablet
          ? 48.h
          : isSmallTablet
              ? 50.h
              : 52.h;

      double fontSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      return Container(
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        color: background,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      );
    },
  );
}
