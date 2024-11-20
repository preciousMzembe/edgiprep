import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget settingsIcon(IconData icon) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 30.r
          : isSmallTablet
              ? 30.r
              : 30.r;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: const Color.fromRGBO(107, 179, 250, 1),
          padding: EdgeInsets.all(15.r),
          child: Icon(
            icon,
            size: iconSize,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );
    },
  );
}
