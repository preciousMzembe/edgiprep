import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget topicTopicName(String text) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 32.sp
          : isSmallTablet
              ? 34.sp
              : 36.sp;

      double rightSpace = isTablet
          ? 180.w
          : isSmallTablet
              ? 170.w
              : 160.w;

      return Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
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
