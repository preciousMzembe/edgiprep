import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonCompletedDetail(String title, String value, bool bolder) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      double subtitleSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return Container(
        padding: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.r,
              color: bolder
                  ? const Color.fromRGBO(237, 239, 242, 1)
                  : Colors.transparent,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // title
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: titleSize,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(92, 101, 120, 1),
              ),
            ),

            // value
            Text(
              value,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: subtitleSize,
                fontWeight: FontWeight.w800,
                color: const Color.fromRGBO(52, 74, 106, 1),
              ),
            ),
          ],
        ),
      );
    },
  );
}
