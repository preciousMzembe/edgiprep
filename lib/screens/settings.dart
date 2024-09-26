import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/screens/about.dart';
import 'package:edgiprep/screens/help.dart';
import 'package:edgiprep/screens/sponsors.dart';
import 'package:edgiprep/screens/terms.dart';
import 'package:edgiprep/screens/user_settings.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                            ),
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 80.h,
                                ),
                                // name
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  userController.user['fullName'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w900,
                                    // color: Colors.white,
                                  ),
                                ),

                                // exam and hours
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // exam
                                    // const Text("Exam: "),
                                    Text(
                                      userController.currentExam['examName'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // dot
                                    // SizedBox(
                                    //   width: 20.w,
                                    // ),
                                    // Icon(
                                    //   FontAwesomeIcons.solidCircle,
                                    //   color: textColor,
                                    //   size: 8,
                                    // ),
                                    // SizedBox(
                                    //   width: 20.w,
                                    // ),

                                    // // hours
                                    // const Text("Practice Hours:"),
                                    // const Text(
                                    //   " 120",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                  ],
                                ),

                                // manage
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => const UserSettings());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 90.w,
                                        ),
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: primaryColor,
                                          ),
                                          color: const Color.fromRGBO(
                                              47, 59, 98, 0.123),
                                          borderRadius:
                                              BorderRadius.circular(80.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Manage Account",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 40.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // profile image
                  Center(
                    child: ClipOval(
                      child: Container(
                        width: 160.h,
                        height: 160.h,
                        color: Colors.white,
                        padding: const EdgeInsets.all(6),
                        child: ClipOval(
                          child: Container(
                            color: primaryColor,
                            // decoration: BoxDecoration(
                            //   image: const DecorationImage(
                            //     image: AssetImage('images/male.jpg'),
                            //     fit: BoxFit.cover,
                            //   ),
                            //   // border: Border.all(
                            //   //   width: 5.0,
                            //   //   color: Colors.white,
                            //   // ),
                            //   borderRadius: BorderRadius.circular(150.r),
                            // ),
                            child: Center(
                              child: Text(
                                userController.user['fullName'][0],
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 80.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // app settings
              SizedBox(
                height: 40.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Terms",
                      style: GoogleFonts.nunito(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Setting(
                      name: "Terms of use",
                      goTo: () {
                        Get.to(() => const Terms());
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Setting(
                      name: "Privacy policy",
                      goTo: () {
                        _openPrivacyPolicy();
                      },
                    ),
                  ],
                ),
              ),

              // help and support
              SizedBox(
                height: 50.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  // vertical: 40.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "About & Support",
                      style: GoogleFonts.nunito(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Setting(
                      name: "About EdgiPrep",
                      goTo: () {
                        Get.to(() => const About());
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Setting(
                      name: "Sponsors",
                      goTo: () {
                        Get.to(() => const Sponsors());
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Setting(
                      name: "Help center",
                      goTo: () {
                        Get.to(() => const Help());
                      },
                    ),
                  ],
                ),
              ),

              // Share
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Share App",
                      style: GoogleFonts.nunito(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 80.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ShareOption(
                            color: const Color.fromRGBO(27, 135, 85, 1),
                            fade: const Color.fromRGBO(27, 135, 85, 0.123),
                            image: "whatsapp.png",
                            send: () {
                              _shareToWhatsApp();
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ShareOption(
                            color: const Color.fromRGBO(8, 102, 255, 1),
                            fade: const Color.fromRGBO(8, 103, 255, 0.123),
                            image: "facebook.png",
                            send: () {
                              _shareToFacebook();
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ShareOption(
                            color: const Color.fromRGBO(197, 53, 96, 1),
                            fade: const Color.fromRGBO(197, 53, 96, 0.123),
                            image: "instagram.png",
                            send: () {
                              _shareToInstagram();
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ShareOption(
                            color: Colors.black,
                            fade: const Color.fromARGB(26, 0, 0, 0),
                            image: "x.png",
                            send: () {
                              _shareToX();
                            },
                          ),
                        ],
                      ),
                    ),

                    // link
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _copyLinkToClipboard();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                            ),
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(47, 59, 98, 0.123),
                              border: Border.all(
                                width: 1.0,
                                color: primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(80.r),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.link,
                                    color: primaryColor,
                                    size: 25.h,
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    "Copy Link",
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w700,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // bottom
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ],
      );
    });
  }

  void _openPrivacyPolicy() async {
    final url = PrivacyUrl;
    if (!await launchUrl(Uri.parse(url!))) {
      debugPrint('Could not launch $url');
    }
  }

  void _shareToWhatsApp() async {
    final url = 'https://wa.me/?text=$AppUrl';
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
  }

  void _shareToFacebook() async {
    final url = 'https://www.facebook.com/sharer/sharer.php?u=$AppUrl';
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
  }

  void _shareToInstagram() async {
    final url = 'https://www.instagram.com/?url=$AppUrl';
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
  }

  void _shareToX() async {
    final url = 'https://twitter.com/intent/tweet?url=$AppUrl';
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
  }

  void _copyLinkToClipboard() {
    Clipboard.setData(ClipboardData(text: AppUrl!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Link copied to clipboard'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primaryColor,
      ),
    );
  }
}

class Setting extends StatelessWidget {
  final String name;
  final Function goTo;
  const Setting({super.key, required this.name, required this.goTo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goTo();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: GoogleFonts.nunito(
                // fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Icon(
              FontAwesomeIcons.angleRight,
              size: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ShareOption extends StatelessWidget {
  final Color color;
  final Color fade;
  final String image;
  final Function send;
  const ShareOption(
      {super.key,
      required this.color,
      required this.image,
      required this.fade,
      required this.send});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        send();
      },
      child: Container(
        width: 80.h,
        height: 80.h,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: color,
          ),
          color: fade,
          borderRadius: BorderRadius.circular(80.r),
        ),
        child: Center(
          child: Image.asset(
            "icons/$image",
            height: 30.h,
            color: color,
          ),
        ),
      ),
    );
  }
}
