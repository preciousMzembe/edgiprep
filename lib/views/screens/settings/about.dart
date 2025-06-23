import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
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

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String currentVersion = "1.0.0";

  Future<void> getVersion() async {
    String version = await getCurrentVersion();

    setState(() {
      currentVersion = version;
    });
  }

  @override
  void initState() {
    super.initState();

    getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double containerSize = isTablet
          ? 200.r
          : isSmallTablet
              ? 210.r
              : 220.r;

      double iconSize = isTablet
          ? 80.r
          : isSmallTablet
              ? 90.r
              : 100.r;

      double textSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

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
                              width: containerSize,
                              height: containerSize,
                              color: const Color.fromARGB(255, 105, 180, 255),
                              child: Center(
                                child: Image.asset(
                                  'icons/transparent_logo.png',
                                  height: iconSize,
                                ),
                              ),
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
                        "Your ultimate study companion for exam preparation! We believe that every student deserves the tools and support to succeed, and $appName is here to help you reach your academic goals with ease and confidence.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: textSize,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(92, 101, 120, 1),
                        ),
                      ),

                      // version
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Version $currentVersion",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: textSize,
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
                        child: settingsOptionBox(
                            "file.svg",
                            "Legal Information",
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
    });
  }
}
