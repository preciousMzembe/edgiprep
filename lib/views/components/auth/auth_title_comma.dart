import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget authTitleComma() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 60.sp
          : isSmallTablet
              ? 70.sp
              : 80.sp;

      return Column(
        children: [
          Text(
            ",",
            style: GoogleFonts.inter(
              fontSize: fontSize,
              color: primaryColor,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      );
    },
  );
}
