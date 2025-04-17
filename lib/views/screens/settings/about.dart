import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_icon.dart';
import 'package:edgiprep/views/components/settings/settings_option_box.dart';
import 'package:edgiprep/views/components/settings/settings_title.dart';
import 'package:edgiprep/views/components/settings/settings_username.dart';
import 'package:edgiprep/views/screens/settings/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: settingsBackButton(),
                            ),
                            settingsTitle("About"),
                          ],
                        ),
                        settingsIcon(FontAwesomeIcons.tag),
                      ],
                    ),

                    // image
                    SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 220.r,
                            height: 220.r,
                            color: const Color.fromRGBO(73, 161, 249, 1),
                          ),
                        ),
                      ],
                    ),

                    // name
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: settingsUsername(appName),
                    ),

                    // info
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Your ultimate study companion for exam preparation! We believe that every student deserves the tools and support to succeed, and EdgiPrep is here to help you reach your academic goals with ease and confidence.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(92, 101, 120, 1),
                      ),
                    ),

                    // version
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Version 1.0.1",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(73, 161, 249, 1),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),

              // options
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const Profile());
                      },
                      child: settingsOptionBox("file.svg", "Legal Information",
                          "Learn our Terms of use & pricy policy"),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    settingsOptionBox("globe.svg", "Official Website",
                        "Visit our website for more information"),
                    SizedBox(
                      height: 30.h,
                    ),
                    settingsOptionBox("message.svg", "Feedback Forum",
                        "Check feedback about us"),
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
    );
  }
}
