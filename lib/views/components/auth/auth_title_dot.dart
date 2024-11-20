import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget authTitleDot() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 16.h
          : isSmallTablet
              ? 16.h
              : 16.h;

      double bottomSpace = isTablet
          ? 14.h
          : isSmallTablet
              ? 18.h
              : 14.h;

      return Column(
        children: [
          Icon(
            FontAwesomeIcons.solidCircle,
            size: iconSize,
            color: primaryColor,
          ),
          SizedBox(
            height: bottomSpace,
          ),
        ],
      );
    },
  );
}
