import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget normalImageButton(
  Color background,
  Color textColor,
  String text,
  double radius,
  String image,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double buttonHeight = isTablet
          ? 80.sp
          : isSmallTablet
              ? 82.h
              : 84.h;

      double imageHeight = isTablet
          ? 24.sp
          : isSmallTablet
              ? 26.h
              : 28.h;

      double fontSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      return ClipRRect(
        borderRadius: BorderRadius.circular(radius.r),
        child: Container(
          height: buttonHeight,
          color: background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: imageHeight,
              ),
              SizedBox(
                width: 30.w,
              ),
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
