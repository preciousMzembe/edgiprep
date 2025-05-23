import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget navOption(String name, String icon, bool active) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 36.sp
          : isSmallTablet
              ? 38.sp
              : 40.sp;

      double fontSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'icons/$icon',
              width: iconSize,
              colorFilter: ColorFilter.mode(
                  active ? primaryColor : unselectedNavOptionColor,
                  BlendMode.srcIn),
            ),
            SizedBox(
              height: 8.h,
            ),
            Center(
              child: Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: active ? primaryColor : unselectedNavOptionColor,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
