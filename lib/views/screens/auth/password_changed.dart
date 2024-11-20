import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/premium/premium_subtitle.dart';
import 'package:edgiprep/views/components/premium/premium_title.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double imageHeight = isTablet
            ? 320.h
            : isSmallTablet
                ? 300.h
                : 280.h;

        return Scaffold(
          backgroundColor: appbarColor,
          body: SafeArea(
            child: Container(
              color: backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.w,
                ),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 150.h,
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
                      child: premiumTitle("Password Changed Successfully"),
                    ),

                    // subtitle
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: premiumSubtitle(
                          "Your password has been updated! You can now log in with your new password. Be sure to keep it safe."),
                    ),

                    // price
                    SizedBox(
                      height: 60.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: normalButton(
                        primaryColor,
                        Colors.white,
                        "Sign In",
                        16,
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
        );
      },
    );
  }
}
