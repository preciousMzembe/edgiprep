import 'package:edgiprep/controllers/navigation/navController.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/dashboard/nav_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget navigationBar(Function(int) navigate) {
  NavController navController = Get.find<NavController>();

  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double navHeight = isTablet
          ? 100.h
          : isSmallTablet
              ? 110.h
              : 120.h;

      double verticalPadding = isTablet
          ? 50.w
          : isSmallTablet
              ? 50.w
              : 50.w;

      return Container(
        height: navHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 2.r,
              color: backgroundColor,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: verticalPadding,
            right: verticalPadding,
          ),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // home
                GestureDetector(
                  onTap: () {
                    navigate(0);
                  },
                  child: navOption(
                    "Home",
                    "home.svg",
                    navController.pageIndex.value == 0,
                  ),
                ),

                // subjects
                GestureDetector(
                  onTap: () {
                    navigate(1);
                  },
                  child: navOption(
                    "Learn",
                    "layers.svg",
                    navController.pageIndex.value == 1,
                  ),
                ),

                // history
                GestureDetector(
                  onTap: () {
                    navigate(2);
                  },
                  child: navOption(
                    "Test",
                    "chart.svg",
                    navController.pageIndex.value == 2,
                  ),
                ),

                // settings
                GestureDetector(
                  onTap: () {
                    navigate(3);
                  },
                  child: navOption(
                    "Settings",
                    "settings.svg",
                    navController.pageIndex.value == 3,
                  ),
                ),
              ],
            );
          }),
        ),
      );
    },
  );
}
