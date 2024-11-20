import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/notifications/notification_change_time_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget notificationSettingsTime() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double vertical = isTablet
          ? 14.h
          : isSmallTablet
              ? 16.h
              : 18.h;

      double horizontal = isTablet
          ? 26.h
          : isSmallTablet
              ? 28.h
              : 30.h;

      return Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              notificationChangeTime(context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontal, vertical: vertical),
                color: const Color.fromRGBO(222, 236, 251, 1),
                child: Text("05:00 AM",
                    style: GoogleFonts.inter(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(52, 74, 106, 1),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      );
    },
  );
}
