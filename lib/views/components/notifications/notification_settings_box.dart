import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/notifications/notification_settings_time.dart';
import 'package:edgiprep/views/components/notifications/notification_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget notificationSettingsBox(String title, String value, String type) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleSize = isTablet
          ? 22.sp
          : isSmallTablet
              ? 24.sp
              : 26.sp;

      double subtitleSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // details
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
                        fontSize: subtitleSize,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(92, 101, 120, 1),
                      ),
                    ),
                  ],
                ),
              ),

              // action
              SizedBox(
                width: 30.w,
              ),
              if (type == "switch") const NotificationSwitch(),
              if (type == "time") notificationSettingsTime(),
            ],
          ),
        ),
      );
    },
  );
}
