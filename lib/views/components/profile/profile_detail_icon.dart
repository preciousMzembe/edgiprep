import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profileDetailIcon(IconData icon) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double boxSize = isTablet
          ? 76.r
          : isSmallTablet
              ? 78.r
              : 80.r;

      double iconSize = isTablet
          ? 24.r
          : isSmallTablet
              ? 26.r
              : 28.r;

      return ClipOval(
        child: Container(
          width: boxSize,
          height: boxSize,
          color: const Color.fromRGBO(222, 236, 251, 1),
          child: Center(
            child: Icon(
              icon,
              color: const Color.fromRGBO(73, 161, 249, 1),
              size: iconSize,
            ),
          ),
        ),
      );
    },
  );
}
