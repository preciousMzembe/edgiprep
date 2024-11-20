import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget subjectsOptionsButton() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double containerSize = isTablet
          ? 56.h
          : isSmallTablet
              ? 58.h
              : 60.h;
      double iconSize = isTablet
          ? 28.h
          : isSmallTablet
              ? 30.h
              : 32.h;

      return ClipOval(
        child: Container(
          width: containerSize,
          height: containerSize,
          color: Colors.white,
          child: Center(
            child: Icon(
              FontAwesomeIcons.ellipsisVertical,
              size: iconSize,
            ),
          ),
        ),
      );
    },
  );
}
