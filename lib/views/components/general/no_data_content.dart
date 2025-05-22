import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget noDataContent(String title, String subtitle) {
  return LayoutBuilder(builder: (context, constraints) {
    bool isTablet = DeviceUtils.isTablet(context);
    bool isSmallTablet = DeviceUtils.isSmallTablet(context);

    double imageHeight = isTablet
        ? 180.h
        : isSmallTablet
            ? 190.h
            : 200.h;

    double titleSize = isTablet
        ? 34.sp
        : isSmallTablet
            ? 36.sp
            : 38.sp;

    double subtitleSize = isTablet
        ? 18.sp
        : isSmallTablet
            ? 20.sp
            : 22.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.h,
        ),
        Image.asset(
          "images/sad.png",
          height: imageHeight,
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          capitalizeWords(title),
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: titleSize,
            fontWeight: FontWeight.w800,
            color: const Color.fromRGBO(52, 74, 106, 1),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: subtitleSize,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(92, 101, 120, 1),
            ),
          ),
        ),
      ],
    );
  });
}
