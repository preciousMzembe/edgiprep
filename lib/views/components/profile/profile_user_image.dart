import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profileUserImage() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageSize = isTablet
          ? 70.r
          : isSmallTablet
              ? 70.r
              : 70.r;

      return Container(
        height: imageSize,
        width: imageSize,
        decoration: BoxDecoration(
          border: Border.all(
            width: 5.r,
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(200.r),
          image: const DecorationImage(
            image: AssetImage(
              "images/user.jpeg",
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}
