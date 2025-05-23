import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget welcomeFadeText(String text) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: secondaryTextColor,
        ),
      );
    },
  );
}
