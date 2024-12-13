import 'package:edgiprep/controllers/notification/notification_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

Widget homeNotificationIcon() {
  NotificationController notificationController =
      Get.find<NotificationController>();

  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 34.sp
          : isSmallTablet
              ? 36.sp
              : 40.sp;

      double height = isTablet
          ? 46.sp
          : isSmallTablet
              ? 48.sp
              : 50.sp;

      double dotSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      return Obx(
        () {
          return Stack(
            children: [
              Container(
                width: height,
                height: height,
                color: Colors.transparent,
                child: Icon(
                  FontAwesomeIcons.bell,
                  size: iconSize,
                  color: notificationController.newNotifications.value
                      ? primaryColor
                      : const Color.fromRGBO(92, 101, 120, 1),
                ),
              ),
              if (notificationController.newNotifications.value)
                Positioned(
                  top: 4.h,
                  right: 4.sp,
                  child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(3.sp),
                      color: backgroundColor,
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.solidCircle,
                          size: dotSize,
                          color: primaryColor,
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
