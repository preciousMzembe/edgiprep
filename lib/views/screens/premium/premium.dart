import 'package:edgiprep/views/components/general/normal_svg_button.dart';
import 'package:edgiprep/views/components/premium/premium_close.dart';
import 'package:edgiprep/views/components/premium/premium_detail.dart';
import 'package:edgiprep/views/components/premium/premium_price_option.dart';
import 'package:edgiprep/views/components/premium/premium_subtitle.dart';
import 'package:edgiprep/views/components/premium/premium_title.dart';
import 'package:edgiprep/views/screens/dashboard/dashboard.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Premium extends StatelessWidget {
  const Premium({super.key});

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
                      height: 30.h,
                    ),
                    // back
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
                      child: premiumTitle(
                          "Unlock Your Full Learning Potential with Premium!"),
                    ),

                    // subtitle
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: premiumSubtitle(
                          "Get access to exclusive features designed to boost your exam preparation and help you achieve top results."),
                    ),

                    // price
                    SizedBox(
                      height: 30.h,
                    ),
                    premiumPriceOption(),

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
                            "Unlimited Quizzes",
                            "Take as many quizzes as you want without any restrictions!",
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          premiumDetail(
                            "premium.svg",
                            "Advanced Lessons",
                            "Access in-depth lessons and additional resources tailored to help you master every subject.",
                          ),
                        ],
                      ),
                    ),

                    // button
                    SizedBox(
                      height: 60.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const Dashboard());
                      },
                      child: normalSvgButton(primaryColor, Colors.white,
                          "Go to Premium", 16, "star.svg"),
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
