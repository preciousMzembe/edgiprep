import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/premium/premium_subtitle.dart';
import 'package:edgiprep/views/components/premium/premium_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

Widget rateContent() {
  return LayoutBuilder(builder: (context, constraints) {
    AuthController authController = Get.find<AuthController>();

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
                    child:
                        premiumTitle("Enjoying EdgiPrep?\nLet the World Know!"),
                  ),

                  // subtitle
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: premiumSubtitle(
                        "We're always working to make learning easier and more fun. Let us know how we're doing by leaving a quick rating and feedback, it really helps!"),
                  ),

                  SizedBox(
                    height: 30.h,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await authController.closeRatePopup();
                          },
                          child: normalButton(
                            unselectedButtonColor,
                            Colors.black,
                            "Not Now",
                            20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final uri = Uri.parse(playStoreLink);
                            if (await canLaunchUrl(uri)) {
                              await authController.markRated();

                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: normalButton(
                            primaryColor,
                            Colors.white,
                            "Rate Now",
                            20,
                          ),
                        ),
                      ),
                    ],
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
