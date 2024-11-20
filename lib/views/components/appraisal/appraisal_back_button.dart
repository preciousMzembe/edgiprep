import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget appraisalBackButton() {
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
          ? 50.h
          : isSmallTablet
              ? 40.h
              : 35.h;

      return Container(
        height: buttonSize,
        width: buttonSize,
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.arrowLeft,
              color: const Color.fromRGBO(52, 74, 106, 1),
              size: iconSize,
            ),
          ],
        ),
      );
    },
  );
}
