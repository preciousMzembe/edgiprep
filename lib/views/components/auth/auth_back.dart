import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget authBack() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double containerSize = isTablet
          ? 46.h
          : isSmallTablet
              ? 48.h
              : 50.h;
      double iconSize = isTablet
          ? 30.h
          : isSmallTablet
              ? 32.h
              : 34.h;

      return Container(
        width: containerSize,
        height: containerSize,
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.arrowLeft,
              size: iconSize,
            ),
          ],
        ),
      );
    },
  );
}
