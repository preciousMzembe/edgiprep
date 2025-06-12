import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget premiumDetail(String icon, String title, String detail) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 24.sp
          : isSmallTablet
              ? 26.sp
              : 28.sp;

      double detailFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      double containerSize = isTablet
          ? 70.r
          : isSmallTablet
              ? 80.r
              : 90.r;

      double iconSize = isTablet
          ? 30.r
          : isSmallTablet
              ? 32.r
              : 34.r;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Container(
              height: containerSize,
              width: containerSize,
              color: primaryColor,
              child: Center(
                child: SvgPicture.asset(
                  'icons/$icon',
                  height: iconSize,
                  width: iconSize,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  detail,
                  style: GoogleFonts.inter(
                    fontSize: detailFontSize,
                    fontWeight: FontWeight.w400,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
