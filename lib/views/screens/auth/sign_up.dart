import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_rich_text.dart';
import 'package:edgiprep/views/components/auth/auth_title_dot.dart';
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

class SignUp extends StatelessWidget {
  final VoidCallback onSignInTap;
  const SignUp({super.key, required this.onSignInTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // title
          authTitleText("Create"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              authTitleText("Account"),
              SizedBox(
                width: 8.w,
              ),
              authTitleDot(),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),

          // username

          const AuthInput(
            label: "Full Name",
            type: TextInputType.name,
            isPassword: false,
            icon: FontAwesomeIcons.solidUser,
            radius: 16,
          ),

          // email
          SizedBox(
            height: 25.h,
          ),
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

          // terms
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.r),
            child: authRichText(
              "By creating an account, you agree to our ",
              [
                TextSpan(
                  text: "terms & conditions ",
                  style: GoogleFonts.inter(
                    color: primaryColor,
                  ),
                ),
                const TextSpan(text: "and "),
                TextSpan(
                  text: "privacy policy",
                  style: GoogleFonts.inter(
                    color: primaryColor,
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
                "Have an account?",
                const Color.fromRGBO(115, 115, 115, 1),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  onSignInTap();
                },
                child: authBottomText(
                  "Sign In",
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
