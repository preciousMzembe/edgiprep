import 'package:edgiprep/controllers/nav_controller.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/controllers/subjects_settings_controller.dart';
import 'package:edgiprep/screens/account.dart';
import 'package:edgiprep/screens/exam.dart';
import 'package:edgiprep/screens/personal_information.dart';
import 'package:edgiprep/screens/settings.dart';
import 'package:edgiprep/screens/subjects_settings.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  SubjectsSettingsController subjectsSettingsController =
      Get.find<SubjectsSettingsController>();

  @override
  void initState() {
    subjectsSettingsController.setSubjects();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constants) {
        return Obx(() {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // top
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // back
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            color: Colors.transparent,
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              size: 40.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      children: [
                        // profile image
                        const SizedBox(
                          height: 10,
                        ),
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
                                      userController.fullName.value[0],
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
                        // Center(
                        //   child: Container(
                        //     width: 160.h,
                        //     height: 160.h,
                        //     decoration: BoxDecoration(
                        //       image: const DecorationImage(
                        //         image: AssetImage('images/male.jpg'),
                        //         fit: BoxFit.cover,
                        //       ),
                        //       // border: Border.all(
                        //       //   width: 5.0,
                        //       //   color: Colors.white,
                        //       // ),
                        //       borderRadius: BorderRadius.circular(150.r),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // Center(
                        //   child: Text(
                        //     "Change Photo",
                        //     style: TextStyle(color: primaryColor),
                        //   ),
                        // ),

                        // Profile
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
                                "My Profile",
                                style: GoogleFonts.nunito(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Setting(
                                name: "Full Name",
                                goTo: () {},
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Setting(
                                name: "Contact",
                                goTo: () {},
                              ),
                            ],
                          ),
                        ),

                        // settings
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
                                "Account Settings",
                                style: GoogleFonts.nunito(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Setting(
                                name: "Login Details",
                                goTo: () {},
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Setting(
                                name: "Exam",
                                goTo: () {
                                  Get.to(() => const Exam());
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Setting(
                                name: "Subjects",
                                goTo: () {
                                  Get.to(() => const SubjectsSettings());
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Setting(
                                name: "Personal information",
                                goTo: () {
                                  Get.to(() => const PersonalInformation());
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Setting(
                                name: "Account",
                                goTo: () {
                                  Get.to(() => const Account());
                                },
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showLogoutDialog(
                                    context,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50.w,
                                  ),
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color:
                                          const Color.fromRGBO(244, 67, 54, 1),
                                    ),
                                    color: const Color.fromRGBO(
                                        244, 67, 54, 0.123),
                                    borderRadius: BorderRadius.circular(80.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Logout",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromRGBO(
                                            244, 67, 54, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // bottom
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    UserController userController = Get.find<UserController>();
    NavController navController = Get.find<NavController>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 180.h,
                            height: 180.h,
                            child: Center(
                              child: ClipOval(
                                child: Container(
                                  color: const Color.fromARGB(57, 244, 67, 54),
                                  padding: EdgeInsets.all(
                                    40.w,
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.powerOff,
                                    color: Colors.red,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 180.h,
                            height: 180.h,
                            child: Center(
                              child: Container(
                                width: 145.h,
                                height: 145.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(85, 244, 67, 54),
                                  borderRadius: BorderRadius.circular(140.r),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Logout",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Are you sure you want logout your account?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600),
                      ),

                      // close
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 60.h,
                                width: 200.w,
                                color: grayColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                ),
                                child: const Center(
                                  child: Text("Cancel"),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                navController.changeSelectedIndex(0);
                                await logout();

                                userController.changeUserKey("");
                              },
                              child: Container(
                                height: 60.h,
                                width: 200.w,
                                color: Colors.red,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Contact extends StatelessWidget {
  final String name;
  final String detail;
  final Icon icon;
  const Contact(
      {super.key,
      required this.name,
      required this.detail,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 30,
      ),
      color: const Color.fromARGB(255, 243, 243, 243),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // icon
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Container(
              height: 90.w,
              width: 90.w,
              color: const Color.fromRGBO(124, 180, 66, 0.123),
              child: Center(
                child: icon,
              ),
            ),
          ),
          // details
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: GoogleFonts.nunito(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  detail,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
