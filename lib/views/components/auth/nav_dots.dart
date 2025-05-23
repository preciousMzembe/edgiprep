import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget navDot(bool active) {
  return LayoutBuilder(builder: (context, constraints) {
    bool isTablet = DeviceUtils.isTablet(context);
    bool isSmallTablet = DeviceUtils.isSmallTablet(context);

    double height = isTablet
        ? 18.h
        : isSmallTablet
            ? 20.h
            : 22.h;

    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        color: active ? primaryColor : Colors.transparent,
        border: Border.all(
          width: 2.r,
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
    );
  });
}
