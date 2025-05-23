import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

Widget profileButtonLoading(
  Color background,
  double radius,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double height = isTablet
          ? 66.h
          : isSmallTablet
              ? 68.h
              : 70.h;

      double iconHeight = isTablet
          ? 66.h
          : isSmallTablet
              ? 68.h
              : 50.h;

      return ClipRRect(
        borderRadius: BorderRadius.circular(radius.r),
        child: Container(
          height: height,
          color: background,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Lottie.asset(
              'icons/loading.json',
              height: iconHeight,
            ),
          ),
        ),
      );
    },
  );
}
