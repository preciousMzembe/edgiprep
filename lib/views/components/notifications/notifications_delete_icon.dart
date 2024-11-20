import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget notificationsDeleteIcon(IconData icon) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 24.r
          : isSmallTablet
              ? 26.r
              : 28.r;

      return ClipRRect(
        borderRadius: BorderRadius.circular(80.r),
        child: Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          padding: EdgeInsets.all(17.r),
          child: Icon(
            icon,
            size: iconSize,
            color: const Color.fromRGBO(52, 74, 106, 1),
          ),
        ),
      );
    },
  );
}
