import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget enrollmentOptionSelectedMark(Color color) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double height = isTablet
          ? 36.r
          : isSmallTablet
              ? 38.r
              : 40.r;

      double iconSize = isTablet
          ? 16.r
          : isSmallTablet
              ? 18.r
              : 20.r;

      return Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 2.r, color: color),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: Icon(
            FontAwesomeIcons.check,
            size: iconSize,
            color: color,
          ),
        ),
      );
    },
  );
}
