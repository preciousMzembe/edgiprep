import 'dart:ui';

import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/profile_button_loading.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
import 'package:edgiprep/views/components/general/username_input_formatter.dart';
import 'package:edgiprep/views/components/profile/delete_text.dart';
import 'package:edgiprep/views/components/profile/profile_detail_edit_icon.dart';
import 'package:edgiprep/views/components/profile/profile_detail_icon.dart';
import 'package:edgiprep/views/components/profile/profile_detail_subtitle.dart';
import 'package:edgiprep/views/components/profile/profile_detail_title.dart';
import 'package:edgiprep/views/components/profile/profile_subtitle.dart';
import 'package:edgiprep/views/components/profile/profile_title.dart';
import 'package:edgiprep/views/components/profile/profile_user_image.dart';
import 'package:edgiprep/views/components/settings/delete_account_content.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_button.dart';
import 'package:edgiprep/views/components/settings/settings_cancel_text.dart';
import 'package:edgiprep/views/components/settings/settings_error_text.dart';
import 'package:edgiprep/views/components/settings/settings_input.dart';
import 'package:edgiprep/views/components/general/pin_input_formatter.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool editName = false;
  bool editUsername = false;
  bool editPassword = false;
  bool editEmail = false;
  bool editPhone = false;

  bool nameLoading = false;
  bool usernameLoading = false;
  bool passwordLoading = false;
  bool emailLoading = false;
  bool phoneLoading = false;

  String nameErorr = "";
  String usernameErorr = "";
  String passwordErorr = "";
  String emailErorr = "";
  String phoneErorr = "";

  void toggleName() {
    setState(() {
      editName = !editName;
    });

    changeNameError("");
  }

  void toggleNameLoading() {
    setState(() {
      nameLoading = !nameLoading;
    });
  }

  void changeNameError(error) {
    setState(() {
      nameErorr = error;
    });
  }

  void toggleUsername() {
    setState(() {
      editUsername = !editUsername;
    });

    changeUsernameError("");
  }

  void toggleUsernameLoading() {
    setState(() {
      usernameLoading = !usernameLoading;
    });
  }

  void changeUsernameError(error) {
    setState(() {
      usernameErorr = error;
    });
  }

  void togglePassword() {
    setState(() {
      editPassword = !editPassword;
    });

    changePasswordError("");
  }

  void togglePasswordLoading() {
    setState(() {
      passwordLoading = !passwordLoading;
    });
  }

  void changePasswordError(error) {
    setState(() {
      passwordErorr = error;
    });
  }

  void toggleEmail() {
    setState(() {
      editEmail = !editEmail;
    });

    changeEmailError("");
  }

  void toggleEmailLoading() {
    setState(() {
      emailLoading = !emailLoading;
    });
  }

  void changeEmailError(error) {
    setState(() {
      emailErorr = error;
    });
  }

  void togglePhone() {
    setState(() {
      editPhone = !editPhone;
    });

    changePhoneError("");
  }

  void togglePhoneLoading() {
    setState(() {
      phoneLoading = !phoneLoading;
    });
  }

  void changePhoneError(error) {
    setState(() {
      phoneErorr = error;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
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
                                            "${authController.user.value?.name.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ')}"),
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
                                    SettingsInput(
                                      controller: nameController,
                                      label: "New Name",
                                      type: TextInputType.text,
                                      isPassword: false,
                                      radius: 20,
                                    ),

                                    // error
                                    if (nameErorr.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          settingsErrorText(nameErorr),
                                        ],
                                      ),

                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                // change name
                                                String name =
                                                    nameController.text.trim();

                                                if (name.isNotEmpty) {
                                                  changeNameError("");

                                                  toggleNameLoading();

                                                  var data =
                                                      await authController
                                                          .changeName(name);

                                                  if (data['status'] ==
                                                      "error") {
                                                    changeNameError(
                                                        data['error']);
                                                  } else {
                                                    nameController.text = "";

                                                    showSnackbar(
                                                        context,
                                                        "Update Successful",
                                                        "Your data was updated successfuly.",
                                                        false);
                                                  }

                                                  toggleNameLoading();
                                                }
                                              },
                                              child: settingsButton(
                                                const Color.fromRGBO(
                                                    35, 131, 226, 1),
                                                Colors.white,
                                                "Update",
                                                16,
                                              ),
                                            ),
                                            if (nameLoading)
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                child: profileButtonLoading(
                                                    unselectedButtonColor, 16),
                                              ),
                                          ],
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

                // username
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
                                        profileDetailTitle("Username"),
                                        profileDetaillSubtitle(
                                            "${authController.user.value?.username}"),
                                      ],
                                    ),
                                  ),

                                  // edit button
                                  if (!editUsername)
                                    GestureDetector(
                                      onTap: () {
                                        toggleUsername();
                                      },
                                      child: profileDetailEditIcon(
                                          FontAwesomeIcons.pen),
                                    ),

                                  if (editUsername)
                                    GestureDetector(
                                      onTap: () {
                                        toggleUsername();
                                      },
                                      child: settingsCancelText("Cancel"),
                                    ),
                                ],
                              ),

                              // edit
                              if (editUsername)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    SettingsInput(
                                      controller: usernameController,
                                      label: "New Username",
                                      type: TextInputType.text,
                                      isPassword: false,
                                      radius: 20,
                                      formatter: UsernameInputFormatter(),
                                    ),

                                    // error
                                    if (usernameErorr.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          settingsErrorText(usernameErorr),
                                        ],
                                      ),

                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                // change username
                                                String username =
                                                    usernameController.text
                                                        .trim();

                                                if (username.isNotEmpty &&
                                                    username.length >= 5) {
                                                  changeUsernameError("");

                                                  toggleUsernameLoading();

                                                  var data =
                                                      await authController
                                                          .changeUsername(
                                                              username);

                                                  if (data['status'] ==
                                                      "error") {
                                                    changeUsernameError(
                                                        data['error']);
                                                  } else {
                                                    usernameController.text =
                                                        "";

                                                    showSnackbar(
                                                        context,
                                                        "Update Successful",
                                                        "Your data was updated successfuly.",
                                                        false);
                                                  }

                                                  toggleUsernameLoading();
                                                } else {
                                                  changeUsernameError(
                                                      "Username must be at least 5 characters.");
                                                }
                                              },
                                              child: settingsButton(
                                                const Color.fromRGBO(
                                                    35, 131, 226, 1),
                                                Colors.white,
                                                "Update",
                                                16,
                                              ),
                                            ),
                                            if (usernameLoading)
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                child: profileButtonLoading(
                                                    unselectedButtonColor, 16),
                                              ),
                                          ],
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
                                        profileDetailTitle("Pin"),
                                        profileDetaillSubtitle("*****"),
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
                                    SettingsInput(
                                      controller: oldPasswordController,
                                      label: "Current Pin",
                                      type: TextInputType.number,
                                      isPassword: true,
                                      radius: 20,
                                      formatter: PinInputFormatter(),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    SettingsInput(
                                      controller: passwordController,
                                      label: "New Pin",
                                      type: TextInputType.number,
                                      isPassword: true,
                                      radius: 20,
                                      formatter: PinInputFormatter(),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    SettingsInput(
                                      controller: confirmPasswordController,
                                      label: "Confirm Pin",
                                      type: TextInputType.number,
                                      isPassword: true,
                                      radius: 20,
                                      formatter: PinInputFormatter(),
                                    ),

                                    // error
                                    if (passwordErorr.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          settingsErrorText(passwordErorr),
                                        ],
                                      ),

                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                // change password

                                                String oldPassword =
                                                    oldPasswordController.text
                                                        .trim();

                                                String password =
                                                    passwordController.text
                                                        .trim();

                                                String confirmPassword =
                                                    confirmPasswordController
                                                        .text
                                                        .trim();

                                                if (oldPassword.isNotEmpty &&
                                                    password.isNotEmpty &&
                                                    confirmPassword
                                                        .isNotEmpty) {
                                                  if (password.length >= 4 &&
                                                      password ==
                                                          confirmPassword) {
                                                    changePasswordError("");

                                                    togglePasswordLoading();

                                                    var data =
                                                        await authController
                                                            .changePassword(
                                                                oldPassword,
                                                                password);

                                                    if (data['status'] ==
                                                        "error") {
                                                      changePasswordError(
                                                          data['error']);
                                                    } else {
                                                      oldPasswordController
                                                          .text = "";
                                                      passwordController.text =
                                                          "";
                                                      confirmPasswordController
                                                          .text = "";

                                                      showSnackbar(
                                                          context,
                                                          "Update Successful",
                                                          "Your data was updated successfuly.",
                                                          false);
                                                    }

                                                    togglePasswordLoading();
                                                  } else {
                                                    if (password.length < 4) {
                                                      changePasswordError(
                                                          "Pin must be at least 4 characters.");
                                                    } else if (password !=
                                                        confirmPassword) {
                                                      changePasswordError(
                                                          "Pin does not match.");
                                                    }
                                                  }
                                                }
                                              },
                                              child: settingsButton(
                                                const Color.fromRGBO(
                                                    35, 131, 226, 1),
                                                Colors.white,
                                                "Update",
                                                16,
                                              ),
                                            ),
                                            if (passwordLoading)
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                child: profileButtonLoading(
                                                    unselectedButtonColor, 16),
                                              ),
                                          ],
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
                                            "${authController.user.value?.email != "" ? authController.user.value?.email : "[ Not set ]"}"),
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
                                    SettingsInput(
                                      controller: emailController,
                                      label: "New Email Address",
                                      type: TextInputType.emailAddress,
                                      isPassword: false,
                                      radius: 20,
                                    ),

                                    // error
                                    if (emailErorr.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          settingsErrorText(emailErorr),
                                        ],
                                      ),

                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                // change email
                                                String email =
                                                    emailController.text.trim();

                                                if (email.isNotEmpty) {
                                                  changeEmailError("");

                                                  toggleEmailLoading();

                                                  // check if email is valid
                                                  if (!GetUtils.isEmail(
                                                      email)) {
                                                    changeEmailError(
                                                        "Invalid email");
                                                    toggleEmailLoading();
                                                    return;
                                                  }

                                                  var data =
                                                      await authController
                                                          .changeEmail(email);

                                                  if (data['status'] ==
                                                      "error") {
                                                    changeEmailError(
                                                        data['error']);
                                                  } else {
                                                    emailController.text = "";

                                                    showSnackbar(
                                                        context,
                                                        "Update Successful",
                                                        "Your data was updated successfuly.",
                                                        false);
                                                  }

                                                  toggleEmailLoading();
                                                }
                                              },
                                              child: settingsButton(
                                                const Color.fromRGBO(
                                                    35, 131, 226, 1),
                                                Colors.white,
                                                "Update",
                                                16,
                                              ),
                                            ),
                                            if (emailLoading)
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                child: profileButtonLoading(
                                                    unselectedButtonColor, 16),
                                              ),
                                          ],
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

                // phone
                // SizedBox(
                //   height: 30.h,
                // ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(25.r),
                //   child: Container(
                //     color: Colors.white,
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 30.w,
                //       vertical: 30.h,
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         // icon
                //         profileDetailIcon(FontAwesomeIcons.phone),

                //         // details
                //         SizedBox(
                //           width: 30.w,
                //         ),
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.stretch,
                //             children: [
                //               // values
                //               Row(
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Expanded(
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.stretch,
                //                       children: [
                //                         profileDetailTitle("Phone Number"),
                //                         profileDetaillSubtitle(
                //                             "265 000 000 000"),
                //                       ],
                //                     ),
                //                   ),

                //                   // edit button
                //                   if (!editPhone)
                //                     GestureDetector(
                //                       onTap: () {
                //                         togglePhone();
                //                       },
                //                       child: profileDetailEditIcon(
                //                           FontAwesomeIcons.pen),
                //                     ),

                //                   if (editPhone)
                //                     GestureDetector(
                //                       onTap: () {
                //                         togglePhone();
                //                       },
                //                       child: settingsCancelText("Cancel"),
                //                     ),
                //                 ],
                //               ),

                //               // edit
                //               if (editPhone)
                //                 Column(
                //                   crossAxisAlignment:
                //                       CrossAxisAlignment.stretch,
                //                   children: [
                //                     SizedBox(
                //                       height: 25.h,
                //                     ),
                //                     SettingsInput(
                //                       controller: phoneController,
                //                       label: "New Phone Number",
                //                       type: TextInputType.number,
                //                       isPassword: false,
                //                       radius: 20,
                //                       formatter: PhoneNumberFormatter(),
                //                     ),

                //                     // error
                //                     if (phoneErorr.isNotEmpty)
                //                       Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.stretch,
                //                         children: [
                //                           SizedBox(
                //                             height: 20.h,
                //                           ),
                //                           settingsErrorText(phoneErorr),
                //                         ],
                //                       ),

                //                     SizedBox(
                //                       height: 20.h,
                //                     ),
                //                     Row(
                //                       children: [
                //                         Stack(
                //                           children: [
                //                             GestureDetector(
                //                               onTap: () async {
                //                                 // change email
                //                                 String phone =
                //                                     phoneController.text.trim();

                //                                 if (phone.isNotEmpty &&
                //                                     phone.length == 15) {
                //                                   changePhoneError("");

                //                                   togglePhoneLoading();

                //                                   var data =
                //                                       await authController
                //                                           .changePhone(phone);

                //                                   if (data['status'] ==
                //                                       "error") {
                //                                     changePhoneError(
                //                                         data['error']);
                //                                   } else {
                //                                     phoneController.text = "";

                //                                     showSnackbar(
                //                                         context,
                //                                         "Update Successful",
                //                                         "Your data was updated successfuly.",
                //                                         false);
                //                                   }

                //                                   togglePhoneLoading();
                //                                 } else {
                //                                   if (phone.length < 15) {
                //                                     changePhoneError(
                //                                         "Please enter a valid phone number.");
                //                                   }
                //                                 }
                //                               },
                //                               child: settingsButton(
                //                                 const Color.fromRGBO(
                //                                     35, 131, 226, 1),
                //                                 Colors.white,
                //                                 "Update",
                //                                 16,
                //                               ),
                //                             ),
                //                             if (phoneLoading)
                //                               Positioned(
                //                                 left: 0,
                //                                 right: 0,
                //                                 child: profileButtonLoading(
                //                                     unselectedButtonColor, 16),
                //                               ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 30.h,
                ),
                profileSubtitle(
                    "We recommend adding your email to ensure you can easily recover your account if you ever forget your password."),

                // delete account
                SizedBox(
                  height: 50.h,
                ),
                profileDetailTitle("Delete Account"),
                SizedBox(height: 16.h),
                profileSubtitle(
                    "Deleting your account will remove all your data from our servers. This action cannot be undone."),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SingleChildScrollView(
                              child: DeleteAccountContent(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      deleteText("Delete Account"),
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
