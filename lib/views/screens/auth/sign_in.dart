import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_title_comma.dart';
import 'package:edgiprep/views/screens/auth/verify.dart';
import 'package:edgiprep/views/components/auth/auth_input.dart';
import 'package:edgiprep/views/components/auth/auth_title_text.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/general/normal_image_button.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatelessWidget {
  final VoidCallback onSignUpTap;
  const SignIn({
    super.key,
    required this.onSignUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // title
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              authTitleText("Hey"),
              SizedBox(
                width: 8.w,
              ),
              authTitleComma(),
            ],
          ),
          authTitleText("Welcome"),
          authTitleText("Back"),
          SizedBox(
            height: 30.h,
          ),

          // email
          const AuthInput(
            label: "Username",
            type: TextInputType.text,
            isPassword: false,
            icon: FontAwesomeIcons.solidUser,
            radius: 16,
          ),

          // password
          SizedBox(
            height: 25.h,
          ),
          const AuthInput(
            label: "Password",
            type: TextInputType.text,
            isPassword: true,
            icon: FontAwesomeIcons.lock,
            radius: 16,
          ),

          // forget password
          // SizedBox(
          //   height: 25.h,
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8.w),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       authBottomText(
          //         "Forget Password?",
          //         const Color.fromRGBO(115, 115, 115, 1),
          //       ),
          //       SizedBox(
          //         width: 10.w,
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           Get.to(() => const ResetPassword());
          //         },
          //         child: authBottomText(
          //           "Recover Here",
          //           primaryColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // continue
          SizedBox(
            height: 35.h,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const Verify());
            },
            child: normalButton(
              primaryColor,
              Colors.white,
              "Continue",
              16,
            ),
          ),

          // or
          SizedBox(
            height: 30.h,
          ),

          Text(
            "OR",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(191, 198, 216, 1),
            ),
          ),

          // google
          SizedBox(
            height: 30.h,
          ),
          normalImageButton(
            unselectedButtonColor,
            Colors.black,
            "Continue with google",
            16,
            "icons/google.png",
          ),

          // login
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                onTap: () {
                  onSignUpTap();
                },
                child: authBottomText(
                  "Sign Up",
                  primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.h,
          ),
        ],
      ),
    );
  }
}
