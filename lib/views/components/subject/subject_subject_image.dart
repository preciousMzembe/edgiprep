import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget subjectSubjectImage(String icon, Color color) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageSize = isTablet
          ? 280.r
          : isSmallTablet
              ? 280.r
              : 280.r;

      return CachedNetworkSVGImage(
        icon,
        height: imageSize,
        width: imageSize,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        errorWidget: SvgPicture.asset(
          "icons/subject.svg",
          height: imageSize,
          width: imageSize,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      );
    },
  );
}
