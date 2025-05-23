import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appraisalImage(String image) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double height = isTablet
          ? 156.sp
          : isSmallTablet
              ? 158.h
              : 160.h;

      return Image.asset(
        "images/$image",
        height: height,
      );
    },
  );
}
