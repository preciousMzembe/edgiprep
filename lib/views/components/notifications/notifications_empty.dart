import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget notificationsEmpty() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 150.h
          : isSmallTablet
              ? 150.h
              : 150.h;

      double titleSize = isTablet
          ? 26.sp
          : isSmallTablet
              ? 28.sp
              : 30.sp;

      double infoSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 80.h,
          ),
          SvgPicture.asset(
            'icons/empty_notifications.svg',
            height: iconSize,
            width: iconSize,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "No Notifications",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: titleSize,
              fontWeight: FontWeight.w800,
              color: const Color.fromRGBO(161, 168, 183, 1),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Text(
              "Notifications will be shown here if you have any",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: infoSize,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(161, 168, 183, 1),
              ),
            ),
          ),
        ],
      );
    },
  );
}
