import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget premiumClose() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double containerSize = isTablet
          ? 70.h
          : isSmallTablet
              ? 60.h
              : 50.h;
      double iconSize = isTablet
          ? 50.h
          : isSmallTablet
              ? 40.h
              : 35.h;

      return Container(
        width: containerSize,
        height: containerSize,
        color: Colors.transparent,
        child: Center(
          child: Icon(
            FontAwesomeIcons.xmark,
            size: iconSize,
          ),
        ),
      );
    },
  );
}
