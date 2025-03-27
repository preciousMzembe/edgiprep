import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/views/components/general/normal_svg_button.dart';
import 'package:edgiprep/views/components/premium/premium_close.dart';
import 'package:edgiprep/views/components/premium/premium_detail.dart';
import 'package:edgiprep/views/components/premium/premium_price_option.dart';
import 'package:edgiprep/views/components/premium/premium_subtitle.dart';
import 'package:edgiprep/views/components/premium/premium_title.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  ConfigService configService = Get.find<ConfigService>();

  String premiumPrice = "--";

  Future<void> getConfigValues() async {
    Config? config = await configService.getConfig();

    setState(() {
      premiumPrice = config!.premiumPrice;
    });
  }

  @override
  void initState() {
    getConfigValues();

    super.initState();
  }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
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
                                  Get.back();
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
                          premiumPriceOption(premiumPrice),

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

                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),

                    // button
                    SizedBox(
                      height: 8.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: normalSvgButton(primaryColor, Colors.white,
                          "Go to Premium", 16, "star.svg"),
                    ),

                    SizedBox(
                      height: 30.h,
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
