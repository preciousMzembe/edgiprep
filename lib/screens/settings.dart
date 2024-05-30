import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // user profile
            Stack(
              children: [
                // back image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                  child: Container(
                    height: 540.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/settings.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      color: const Color.fromRGBO(65, 75, 105, 0.863),
                      // color: Color.fromRGBO(47, 59, 98, 0.911),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      // profile image
                      Center(
                        child: Container(
                          width: 160.h,
                          height: 160.h,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('images/male.jpg'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              width: 5.0,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(150.r),
                          ),
                        ),
                      ),

                      // name
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Precious Mzembe",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w900,
                          height: 1.3,
                          color: Colors.white,
                        ),
                      ),

                      // manage button
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                              vertical: 20.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2.0,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(80.r),
                            ),
                            child: Center(
                              child: Text(
                                "Manage Account",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // infor
                      SizedBox(
                        height: 40.h,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 40.w,
                          ),
                          color: const Color.fromARGB(255, 47, 59, 98),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // XP
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(40.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 30.h,
                                    horizontal: 30.w,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "icons/star.png",
                                        height: 60.h,
                                        color: secondaryColor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total XP",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 179, 179, 179),
                                            ),
                                          ),
                                          Text(
                                            "5030",
                                            style: GoogleFonts.nunito(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Streak
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(40.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 30.h,
                                    horizontal: 30.w,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "icons/fire.png",
                                        height: 60.h,
                                        color: secondaryColor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Streak",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 179, 179, 179),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "9 ",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "days",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: const Color.fromARGB(
                                                      255, 179, 179, 179),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // app settings
                      SizedBox(
                        height: 30.h,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 40.w,
                          ),
                          color: const Color.fromARGB(115, 47, 59, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "App Settings",
                                style: GoogleFonts.nunito(
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              const Setting(name: "Exam Settings"),
                              SizedBox(
                                height: 20.h,
                              ),
                              const Setting(name: "Test Settings"),
                              SizedBox(
                                height: 20.h,
                              ),
                              const Setting(name: "Quiz Settings"),
                            ],
                          ),
                        ),
                      ),

                      // help and support
                      SizedBox(
                        height: 30.h,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 40.w,
                          ),
                          color: const Color.fromARGB(115, 47, 59, 98),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "About & Support",
                                style: GoogleFonts.nunito(
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              const Setting(name: "About EdgiPrep"),
                              SizedBox(
                                height: 20.h,
                              ),
                              const Setting(name: "Sponsors"),
                              SizedBox(
                                height: 20.h,
                              ),
                              const Setting(name: "Help"),
                            ],
                          ),
                        ),
                      ),

                      // Share
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Share App",
                        style: GoogleFonts.nunito(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 80.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const ShareOption(
                                color: Color.fromRGBO(27, 135, 85, 1),
                                image: "whatsapp.png"),
                            SizedBox(
                              width: 20.w,
                            ),
                            const ShareOption(
                                color: Color.fromRGBO(8, 102, 255, 1),
                                image: "facebook.png"),
                            SizedBox(
                              width: 20.w,
                            ),
                            const ShareOption(
                                color: Color.fromRGBO(197, 53, 96, 1),
                                image: "instagram.png"),
                            SizedBox(
                              width: 20.w,
                            ),
                            const ShareOption(
                                color: Colors.black, image: "x.png"),
                          ],
                        ),
                      ),

                      // link
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 20.h,
                              ),
                              height: 80.h,
                              color: progressColor,
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
                                        fontSize: 25.sp,
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
              ],
            ),

            // bottom
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ],
    );
  }
}

class Setting extends StatelessWidget {
  final String name;
  const Setting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: GoogleFonts.nunito(
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        Icon(
          FontAwesomeIcons.angleRight,
          size: 25.h,
        ),
      ],
    );
  }
}

class ShareOption extends StatelessWidget {
  final Color color;
  final String image;
  const ShareOption({super.key, required this.color, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.h,
      height: 80.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: color,
        ),
        borderRadius: BorderRadius.circular(80.r),
      ),
      child: Center(
        child: Image.asset(
          "icons/$image",
          height: 30.h,
          color: color,
        ),
      ),
    );
  }
}
