import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget lessonBackButton() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double buttonSize = isTablet
          ? 70.r
          : isSmallTablet
              ? 70.r
              : 70.r;

      double iconSize = isTablet
          ? 30.r
          : isSmallTablet
              ? 30.r
              : 30.r;

      return ClipOval(
        child: Container(
          height: buttonSize,
          width: buttonSize,
          color: Colors.white,
          child: Center(
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: const Color.fromRGBO(73, 161, 249, 1),
              size: iconSize,
            ),
          ),
        ),
      );
    },
  );
}
