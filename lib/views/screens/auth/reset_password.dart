import 'package:edgiprep/views/components/auth/auth_back.dart';
import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_input.dart';
import 'package:edgiprep/views/components/auth/auth_title_dot.dart';
import 'package:edgiprep/views/components/auth/auth_title_text.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/screens/auth/verify.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  dispose() {
    emailController.dispose();
    super.dispose();
  }

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
                        authTitleText("Reset"),
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
                          "Don't worry! We'll help you get back into your account. Enter your registered email address, and we'll send you a verification code to reset your password.",
                          const Color.fromRGBO(115, 115, 115, 1),
                        ),

                        // email
                        SizedBox(
                          height: 35.h,
                        ),
                         AuthInput(
                          label: "Email",
                          type: TextInputType.emailAddress,
                          isPassword: false,
                          icon: FontAwesomeIcons.solidEnvelope,
                          radius: 16,
                          controller: emailController,
                        ),
                        // continue
                        SizedBox(
                          height: 35.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const Verify(
                                  resetPassword: true,
                                ));
                          },
                          child: normalButton(
                            primaryColor,
                            Colors.white,
                            "Continue",
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
