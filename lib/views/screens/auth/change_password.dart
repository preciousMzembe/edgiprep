import 'package:edgiprep/views/components/auth/auth_back.dart';
import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_input.dart';
import 'package:edgiprep/views/components/auth/auth_title_dot.dart';
import 'package:edgiprep/views/components/auth/auth_title_text.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/screens/auth/password_changed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30.h,
              ),
              // back
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: authBack(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                  ],
                ),
              ),
              // auth body
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: SingleChildScrollView(
                    // reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // title
                        authTitleText("Change"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            authTitleText("Your Password"),
                            SizedBox(
                              width: 8.w,
                            ),
                            authTitleDot(),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        authBottomText(
                          "Please create a strong new password below, one that's secure and easy for you to remember.",
                          const Color.fromRGBO(115, 115, 115, 1),
                        ),

                        // new password
                        SizedBox(
                          height: 35.h,
                        ),
                        const AuthInput(
                          label: "New Password",
                          type: TextInputType.text,
                          isPassword: true,
                          icon: FontAwesomeIcons.lock,
                          radius: 16,
                        ),

                        // confirm password
                        SizedBox(
                          height: 25.h,
                        ),
                        const AuthInput(
                          label: "Confirm Password",
                          type: TextInputType.text,
                          isPassword: true,
                          icon: FontAwesomeIcons.lock,
                          radius: 16,
                        ),
                        // continue
                        SizedBox(
                          height: 35.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.to(() => const PasswordChanged());
                          },
                          child: normalButton(
                            primaryColor,
                            Colors.white,
                            "Update Password",
                            16,
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
