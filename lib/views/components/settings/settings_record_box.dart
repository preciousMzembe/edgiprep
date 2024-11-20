import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget settingsRecordBox(String icon, String title, String value) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 60.r
          : isSmallTablet
              ? 60.r
              : 60.r;

      double titleSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      double valueSize = isTablet
          ? 30.sp
          : isSmallTablet
              ? 32.sp
              : 34.sp;

      return ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          color: const Color.fromRGBO(35, 131, 226, 0.19),
          padding: EdgeInsets.all(30.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'icons/$icon',
                height: iconSize,
                width: iconSize,
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(35, 131, 226, 1), BlendMode.srcIn),
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
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(52, 74, 106, 1),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: valueSize,
                        fontWeight: FontWeight.w800,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
