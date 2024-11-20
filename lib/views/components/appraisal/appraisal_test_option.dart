import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appraisalTestOption(
  BuildContext context,
  String icon,
  String name,
  String description,
  Color backgroundColor,
  Color iconBackgroundColor,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageHeight = isTablet
          ? 24.sp
          : isSmallTablet
              ? 26.h
              : 28.h;

      double fontSize = isTablet
          ? 26.sp
          : isSmallTablet
              ? 28.sp
              : 30.sp;

      double subtitleFontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return Container(
        width: (MediaQuery.of(context).size.width - 220.w) / 2,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 76.r,
                      width: 76.r,
                      color: iconBackgroundColor,
                      child: Center(
                        child: SvgPicture.asset(
                          'icons/$icon',
                          height: imageHeight,
                          width: imageHeight,
                          colorFilter: ColorFilter.mode(
                              backgroundColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: 100.h,
                ),
              ),
              Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
