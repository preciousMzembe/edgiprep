import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget settingsUserImage() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageSize = isTablet
          ? 200.r
          : isSmallTablet
              ? 200.r
              : 200.r;

      double buttonSize = isTablet
          ? 64.r
          : isSmallTablet
              ? 64.r
              : 64.r;

      double iconSize = isTablet
          ? 30.r
          : isSmallTablet
              ? 30.r
              : 30.r;

      return Stack(
        children: [
          // image
          Container(
            height: imageSize,
            width: imageSize,
            decoration: BoxDecoration(
              border: Border.all(
                width: 15.r,
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
          ),

          // image button
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipOval(
              child: Container(
                height: buttonSize,
                width: buttonSize,
                color: Colors.white,
                child: Center(
                  child: SvgPicture.asset(
                    'icons/camera.svg',
                    height: iconSize,
                    width: iconSize,
                    colorFilter:
                        ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
