import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget subjectSubjectImage(String image, Color color) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageSize = isTablet
          ? 300.r
          : isSmallTablet
              ? 300.r
              : 300.r;

      return SvgPicture.asset(
        'icons/$image',
        height: imageSize,
        width: imageSize,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    },
  );
}
