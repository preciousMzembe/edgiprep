import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget challengeImage() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double height = isTablet
          ? 180.sp
          : isSmallTablet
              ? 170.h
              : 160.h;

      return Image.asset(
        "images/challenge.jpg",
        height: height,
      );
    },
  );
}
