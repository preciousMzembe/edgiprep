import 'dart:ui';

import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/normal_svg_button.dart';
import 'package:edgiprep/views/components/settings/logout_content.dart';
import 'package:edgiprep/views/components/settings/settings_icon.dart';
import 'package:edgiprep/views/components/settings/settings_option_box.dart';
import 'package:edgiprep/views/components/settings/settings_record_box.dart';
import 'package:edgiprep/views/components/settings/settings_title.dart';
import 'package:edgiprep/views/components/settings/settings_user_email.dart';
import 'package:edgiprep/views/components/settings/settings_user_image.dart';
import 'package:edgiprep/views/components/settings/settings_username.dart';
import 'package:edgiprep/views/components/subjects/subjects_options_title.dart';
import 'package:edgiprep/views/screens/premium/premium.dart';
import 'package:edgiprep/views/screens/settings/about.dart';
import 'package:edgiprep/views/screens/settings/enrollment_settings.dart';
import 'package:edgiprep/views/screens/settings/notifications_settings.dart';
import 'package:edgiprep/views/screens/settings/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Obx(() {
          return Container(
            color: backgroundColor,
            child: ListView(
              children: [
                // top
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 30.h,
                  ),
                  color: const Color.fromRGBO(215, 235, 255, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // settings
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          settingsIcon(FontAwesomeIcons.gear),
                          SizedBox(
                            width: 20.w,
                          ),
                          settingsTitle("Settings"),
                        ],
                      ),

                      // image
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          settingsUserImage(),
                        ],
                      ),

                      // name
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: settingsUsername(
                            "${authController.user.value?.name}"),
                      ),

                      // email
                      Center(
                        child: settingsUserEmail(
                            "${authController.user.value?.email}"),
                      ),

                      // records
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        children: [
                          // xps
                          Expanded(
                            child: settingsRecordBox(
                              "flame.svg",
                              "Total XPs",
                              "${authController.user.value?.xp}",
                            ),
                          ),

                          SizedBox(
                            width: 30.w,
                          ),

                          // streak
                          Expanded(
                            child: settingsRecordBox(
                              "star.svg",
                              "Streak",
                              "${authController.user.value?.streak}",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),

                // options
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: subjectsOptionsTitle("Options"),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const Profile());
                        },
                        child: settingsOptionBox("user.svg", "Profile",
                            "Customize your profile settings"),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Premium());
                        },
                        child: settingsOptionBox(
                            "wallet.svg", "Payments", "Add payment methods"),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const EnrollmentSettings());
                        },
                        child: settingsOptionBox("writing.svg", "Enrollment",
                            "Add / remove exams and subjects"),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const NotificationsSettings());
                        },
                        child: settingsOptionBox("bell.svg", "Notifications",
                            "Customize notification settings"),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const About());
                        },
                        child: settingsOptionBox("tag.svg", "About",
                            "About EdgiPrep & privacy policy"),
                      ),

                      // button
                      SizedBox(
                        height: 50.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            builder: (BuildContext context) => BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: logoutContent(),
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(0),
                              ),
                            ),
                          );
                        },
                        child: normalSvgButton(
                          const Color.fromRGBO(35, 131, 226, 1),
                          Colors.white,
                          "SignOut",
                          20,
                          "power.svg",
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
