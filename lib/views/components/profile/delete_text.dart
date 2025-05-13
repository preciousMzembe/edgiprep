import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget deleteText(String name) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      return Text(name,
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(254, 101, 93, 1),
          ));
    },
  );
}
