import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget homeXpStreak(
  String icon,
  String title,
  String value,
  Color background,
  Color iconColor,
  double titleSize,
  double valueSize,
  double iconSize,
) {
  return Container(
    padding: EdgeInsets.all(30.w),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(22.r),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'icons/$icon',
          height: iconSize,
          width: iconSize,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: valueSize,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
