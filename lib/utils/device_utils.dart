import 'package:flutter/material.dart';

class DeviceUtils {
  static bool isTablet(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 600; // Regular tablet
  }

  static bool isSmallTablet(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 530 && screenWidth < 600; // Small tablet
  }

  static bool isSmallWeb(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 800; // Small web
  }
}
