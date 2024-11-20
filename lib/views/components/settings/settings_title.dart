import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget settingsTitle(String name) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return Text(
        name,
        style: GoogleFonts.inter(
          color: const Color.fromRGBO(52, 74, 106, 1),
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      );
    },
  );
}
