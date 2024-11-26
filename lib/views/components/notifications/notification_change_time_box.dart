import 'dart:ui';

import 'package:edgiprep/controllers/notification/notification_controller.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/notifications/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void notificationChangeTime(BuildContext context) {
  NotificationController notificationController =
      Get.find<NotificationController>();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = DeviceUtils.isTablet(context);
          bool isSmallTablet = DeviceUtils.isSmallTablet(context);

          double boxWidth = isTablet
              ? 500.w
              : isSmallTablet
                  ? 500.w
                  : 500.w;

          double titleFontSize = isTablet
              ? 32.sp
              : isSmallTablet
                  ? 34.sp
                  : 36.sp;

          double subtitleFontSize = isTablet
              ? 18.sp
              : isSmallTablet
                  ? 20.sp
                  : 22.sp;

          double height = isTablet
              ? 64.sp
              : isSmallTablet
                  ? 74.h
                  : 84.h;

          double fontSize = isTablet
              ? 18.sp
              : isSmallTablet
                  ? 20.sp
                  : 24.sp;

          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Container(
                    width: boxWidth,
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.w, vertical: 80.h),
                    child: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            "Time Picker",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w800,
                              color: const Color.fromRGBO(52, 74, 106, 1),
                            ),
                          ),

                          // text
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Choose and adjust the reminder time as needed.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(92, 101, 120, 1),
                            ),
                          ),

                          SizedBox(
                            height: 40.h,
                          ),
                          const TimePicker(),
                          // button
                          SizedBox(
                            height: 40.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              notificationController.changeTime();
                              Navigator.pop(context);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: height,
                                color: const Color.fromRGBO(35, 131, 226, 1),
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: Center(
                                  child: Text(
                                    "Set Time",
                                    style: GoogleFonts.inter(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
