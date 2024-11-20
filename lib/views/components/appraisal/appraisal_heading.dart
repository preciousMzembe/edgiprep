import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appraisalHeading(String text) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double textSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return Text(
        text,
        style: GoogleFonts.inter(
          fontSize: textSize,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(52, 74, 106, 1),
        ),
      );
    },
  );
}
