import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/profile/profile_detail_edit_icon.dart';
import 'package:edgiprep/views/components/profile/profile_detail_icon.dart';
import 'package:edgiprep/views/components/profile/profile_detail_subtitle.dart';
import 'package:edgiprep/views/components/profile/profile_detail_title.dart';
import 'package:edgiprep/views/components/profile/profile_subtitle.dart';
import 'package:edgiprep/views/components/profile/profile_title.dart';
import 'package:edgiprep/views/components/profile/profile_user_image.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_button.dart';
import 'package:edgiprep/views/components/settings/settings_cancel_text.dart';
import 'package:edgiprep/views/components/settings/settings_error_text.dart';
import 'package:edgiprep/views/components/settings/settings_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool editName = false;
  bool editPassword = false;
  bool editEmail = false;

  void toggleName() {
    setState(() {
      editName = !editName;
    });
  }

  void togglePassword() {
    setState(() {
      editPassword = !editPassword;
    });
  }

  void toggleEmail() {
    setState(() {
      editEmail = !editEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Obx(() {
          return Container(
            color: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // back and profile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: settingsBackButton(),
                    ),
                    profileUserImage(),
                  ],
                ),

                // title and subtitle
                SizedBox(
                  height: 30.h,
                ),
                profileTitle("Profile"),
                profileSubtitle("Manage your account details"),

                // options
                SizedBox(
                  height: 40.h,
                ),

                // name
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 30.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // icon
                        profileDetailIcon(FontAwesomeIcons.alignLeft),

                        // details
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // values
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        profileDetailTitle("Name"),
                                        profileDetaillSubtitle(
                                            "${authController.user.value?.name}"),
                                      ],
                                    ),
                                  ),

                                  // edit button
                                  if (!editName)
                                    GestureDetector(
                                      onTap: () {
                                        toggleName();
                                      },
                                      child: profileDetailEditIcon(
                                          FontAwesomeIcons.pen),
                                    ),

                                  if (editName)
                                    GestureDetector(
                                      onTap: () {
                                        toggleName();
                                      },
                                      child: settingsCancelText("Cancel"),
                                    ),
                                ],
                              ),

                              // edit
                              if (editName)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    const SettingsInput(
                                      label: "New Name",
                                      type: TextInputType.text,
                                      isPassword: false,
                                      radius: 20,
                                    ),

                                    // error
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        settingsErrorText(
                                            "The name should have at least 2 characters and not contain special characters."),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      children: [
                                        settingsButton(
                                          const Color.fromRGBO(35, 131, 226, 1),
                                          Colors.white,
                                          "Update",
                                          16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // password
                SizedBox(
                  height: 30.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 30.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // icon
                        profileDetailIcon(FontAwesomeIcons.lock),

                        // details
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // values
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        profileDetailTitle("Password"),
                                        profileDetaillSubtitle("********"),
                                      ],
                                    ),
                                  ),

                                  // edit button
                                  if (!editPassword)
                                    GestureDetector(
                                      onTap: () {
                                        togglePassword();
                                      },
                                      child: profileDetailEditIcon(
                                          FontAwesomeIcons.pen),
                                    ),

                                  if (editPassword)
                                    GestureDetector(
                                      onTap: () {
                                        togglePassword();
                                      },
                                      child: settingsCancelText("Cancel"),
                                    ),
                                ],
                              ),

                              // edit
                              if (editPassword)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    const SettingsInput(
                                      label: "New Password",
                                      type: TextInputType.text,
                                      isPassword: true,
                                      radius: 20,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    const SettingsInput(
                                      label: "Confirm Password",
                                      type: TextInputType.text,
                                      isPassword: true,
                                      radius: 20,
                                    ),

                                    // error
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        settingsErrorText(
                                            "The password should not be less than 8 characters."),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      children: [
                                        settingsButton(
                                          const Color.fromRGBO(35, 131, 226, 1),
                                          Colors.white,
                                          "Update",
                                          16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // email
                SizedBox(
                  height: 30.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 30.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // icon
                        profileDetailIcon(FontAwesomeIcons.solidEnvelope),

                        // details
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // values
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        profileDetailTitle("Email"),
                                        profileDetaillSubtitle(
                                            "${authController.user.value?.email}"),
                                      ],
                                    ),
                                  ),

                                  // edit button
                                  if (!editEmail)
                                    GestureDetector(
                                      onTap: () {
                                        toggleEmail();
                                      },
                                      child: profileDetailEditIcon(
                                          FontAwesomeIcons.pen),
                                    ),

                                  if (editEmail)
                                    GestureDetector(
                                      onTap: () {
                                        toggleEmail();
                                      },
                                      child: settingsCancelText("Cancel"),
                                    ),
                                ],
                              ),

                              // edit
                              if (editEmail)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    const SettingsInput(
                                      label: "New Email Address",
                                      type: TextInputType.emailAddress,
                                      isPassword: false,
                                      radius: 20,
                                    ),

                                    // error
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        settingsErrorText(
                                            "The email address already used for another account."),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      children: [
                                        settingsButton(
                                          const Color.fromRGBO(35, 131, 226, 1),
                                          Colors.white,
                                          "Update",
                                          16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // delete account
                SizedBox(
                  height: 60.h,
                ),
                normalButton(
                  const Color.fromRGBO(254, 101, 93, 1),
                  Colors.white,
                  "Delete Account",
                  25,
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
