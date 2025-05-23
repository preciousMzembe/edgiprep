import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget subjectSubjectDescription(String text) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double rightSpace = isTablet
          ? 180.w
          : isSmallTablet
              ? 190.w
              : 200.w;

      return Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: const Color.fromRGBO(236, 239, 245, 1),
              ),
            ),
          ),
          SizedBox(
            width: rightSpace,
          ),
        ],
      );
    },
  );
}
