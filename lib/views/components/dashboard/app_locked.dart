import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/dashboard/lock_point.dart';
import 'package:edgiprep/views/components/premium/premium_close.dart';
import 'package:edgiprep/views/components/premium/premium_detail.dart';
import 'package:edgiprep/views/components/premium/premium_subtitle.dart';
import 'package:edgiprep/views/components/premium/premium_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appLocked() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageHeight = isTablet
          ? 320.h
          : isSmallTablet
              ? 300.h
              : 280.h;

      return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.w,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        // back
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: premiumClose(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        // image
                        Center(
                          child: Image.asset(
                            "images/password.png",
                            height: imageHeight,
                          ),
                        ),

                        // title
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: premiumTitle(
                              "EdgiPrep Is Currently Undergoing Maintenance."),
                        ),

                        // subtitle
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: premiumSubtitle(
                              "We're making some important updates to improve your experience. The app is temporarily locked and will be available again soon."),
                        ),

                        // point
                        SizedBox(
                          height: 30.h,
                        ),
                        lockPoint(),

                        // details
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 35.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              premiumDetail(
                                "premium.svg",
                                "Updating in Progress",
                                "New features and improvements are on the way.",
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              premiumDetail(
                                "premium.svg",
                                "Maintenance Mode",
                                "We're refreshing the app for better performance.",
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
