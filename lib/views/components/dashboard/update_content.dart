import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/premium/premium_subtitle.dart';
import 'package:edgiprep/views/components/premium/premium_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

Widget updateContent() {
  return LayoutBuilder(builder: (context, constraints) {
    bool isTablet = DeviceUtils.isTablet(context);
    bool isSmallTablet = DeviceUtils.isSmallTablet(context);

    double imageHeight = isTablet
        ? 290.h
        : isSmallTablet
            ? 270.h
            : 260.h;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(40.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 60.w,
                horizontal: 40.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // image
                  Center(
                    child: Image.asset(
                      "images/premium.png",
                      height: imageHeight,
                    ),
                  ),

                  // title
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: premiumTitle("There Is a New Update Available!"),
                  ),

                  // subtitle
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: premiumSubtitle(
                        "Please update the app to enjoy the latest features and improvements."),
                  ),

                  SizedBox(
                    height: 30.h,
                  ),

                  GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse(playStoreLink);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        print('Could not launch the update URL.');
                      }
                    },
                    child: normalButton(
                        primaryColor, Colors.white, "Update Now", 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  });
}
