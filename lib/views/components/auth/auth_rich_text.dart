import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget authRichText(String mainText, List<TextSpan> otherText) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return RichText(
        text: TextSpan(
          style: GoogleFonts.inter(
              color: const Color.fromRGBO(115, 115, 115, 1),
              fontSize: fontSize,
              fontWeight: FontWeight.w500),
          text: mainText,
          children: [
            ...otherText,
          ],
        ),
      );
    },
  );
}
