import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget settingsOptionBox(String icon, String title, String value) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 50.r
          : isSmallTablet
              ? 50.r
              : 50.r;

      double titleSize = isTablet
          ? 22.sp
          : isSmallTablet
              ? 24.sp
              : 26.sp;

      double valueSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.h,
          ),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // icon
              SvgPicture.asset(
                'icons/$icon',
                height: iconSize,
                width: iconSize,
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(104, 180, 255, 1), BlendMode.srcIn),
              ),

              // details
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
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(52, 74, 106, 1),
                      ),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: valueSize,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(161, 168, 183, 1),
                      ),
                    ),
                  ],
                ),
              ),

              // arrow
              SizedBox(
                width: 30.w,
              ),
              Icon(
                FontAwesomeIcons.angleRight,
                size: 30.r,
                color: const Color.fromRGBO(104, 180, 255, 1),
              ),
            ],
          ),
        ),
      );
    },
  );
}
