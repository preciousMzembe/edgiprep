import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget subjectsAddSubject() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 22.sp
          : isSmallTablet
              ? 24.sp
              : 26.sp;

      double subtitleFontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double buttonSize = isTablet
          ? 82.r
          : isSmallTablet
              ? 84.r
              : 86.r;

      double iconSize = isTablet
          ? 26.r
          : isSmallTablet
              ? 28.r
              : 30.r;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.all(40.w),
          color: const Color.fromRGBO(225, 229, 239, 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Enroll New Subjet",
                      style: GoogleFonts.inter(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(101, 117, 143, 1),
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "Add / Enroll new subject with few clicks",
                      style: GoogleFonts.inter(
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(139, 144, 149, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              ClipOval(
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
                  color: const Color.fromRGBO(104, 180, 255, 1),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.plus,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
