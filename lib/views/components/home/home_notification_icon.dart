import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget homeNotificationIcon() {
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

      return Container(
        width: height,
        height: height,
        color: Colors.transparent,
        child: Icon(
          FontAwesomeIcons.bell,
          size: iconSize,
          color: const Color.fromRGBO(92, 101, 120, 1),
        ),
      );
    },
  );
}
