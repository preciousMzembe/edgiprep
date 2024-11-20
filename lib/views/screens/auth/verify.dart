import 'package:edgiprep/views/components/auth/auth_back.dart';
import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_rich_text.dart';
import 'package:edgiprep/views/components/auth/auth_title_dot.dart';
import 'package:edgiprep/views/components/auth/auth_title_text.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/screens/auth/change_password.dart';
import 'package:edgiprep/views/screens/wrapper.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verify extends StatefulWidget {
  final bool resetPassword;
  const Verify({
    super.key,
    this.resetPassword = false,
  });

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double boxHeight = isTablet
            ? 78.h
            : isSmallTablet
                ? 80.h
                : 84.h;

        double fontSize = isTablet
            ? 16.sp
            : isSmallTablet
                ? 18.sp
                : 22.sp;

        double horizontalPadding = isTablet
            ? 100.w
            : isSmallTablet
                ? 80.w
                : 0.w;

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
                            authTitleText("Verify"),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                authTitleText("Your Account"),
                                SizedBox(
                                  width: 8.w,
                                ),
                                authTitleDot(),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            authRichText(
                              "We've send 5-digit code to ",
                              [
                                TextSpan(
                                  text: "example@gmail.com",
                                  style: GoogleFonts.inter(
                                    color: primaryColor,
                                  ),
                                ),
                                const TextSpan(
                                    text:
                                        ". Please enter it below to verify your account."),
                                TextSpan(
                                  text: "",
                                  style: GoogleFonts.inter(
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            // pin input
                            SizedBox(
                              height: 35.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              child: PinCodeTextField(
                                appContext: context,
                                length: 5,
                                obscureText: true,
                                obscuringCharacter: '*',
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(20.r),
                                  fieldHeight: boxHeight,
                                  fieldWidth: boxHeight,
                                  activeFillColor: Colors.white,
                                  activeColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  selectedColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  inactiveColor: Colors.white,
                                  errorBorderColor: Colors.white,
                                  borderWidth: 0,
                                ),
                                cursorColor: primaryColor,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                controller: pinController,
                                keyboardType: TextInputType.number,
                                textStyle: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: fontSize,
                                ),
                                boxShadows: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10.r,
                                  )
                                ],
                                onCompleted: (v) {
                                  debugPrint("Completed");
                                },
                                beforeTextPaste: (text) {
                                  debugPrint("Allowing to paste $text");
                                  return true;
                                },
                              ),
                            ),

                            // resend
                            Padding(
                              padding: EdgeInsets.only(left: 8.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  authBottomText(
                                    "Do not have an account?",
                                    const Color.fromRGBO(115, 115, 115, 1),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: authBottomText(
                                      "Resend",
                                      primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // continue
                            SizedBox(
                              height: 35.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.resetPassword) {
                                  // change password
                                  Get.to(() => const ChangePassword());
                                } else {
                                  // login
                                  Get.to(() => const Wrapper());
                                }
                              },
                              child: normalButton(
                                primaryColor,
                                Colors.white,
                                "Verify Your Account",
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
      },
    );
  }
}
