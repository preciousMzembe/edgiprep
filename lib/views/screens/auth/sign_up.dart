import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_rich_text.dart';
import 'package:edgiprep/views/components/auth/auth_title_dot.dart';
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

class SignUp extends StatefulWidget {
  final VoidCallback onSignInTap;
  const SignUp({super.key, required this.onSignInTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthController authController = Get.find<AuthController>();
  EnrollmentService enrollmentService = Get.find<EnrollmentService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 60.h,
          ),
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

          AuthInput(
            label: "Full Name",
            type: TextInputType.name,
            isPassword: false,
            icon: FontAwesomeIcons.solidUser,
            radius: 16,
            controller: nameController,
          ),

          // email
          SizedBox(
            height: 25.h,
          ),
          AuthInput(
            label: "Username",
            type: TextInputType.text,
            isPassword: false,
            icon: FontAwesomeIcons.solidUser,
            radius: 16,
            controller: usernameController,
          ),

          // password
          SizedBox(
            height: 25.h,
          ),
          AuthInput(
            label: "Password",
            type: TextInputType.text,
            isPassword: true,
            icon: FontAwesomeIcons.lock,
            radius: 16,
            controller: passwordController,
          ),

          // confirm password
          SizedBox(
            height: 25.h,
          ),
          AuthInput(
            label: "Confirm Password",
            type: TextInputType.text,
            isPassword: true,
            icon: FontAwesomeIcons.lock,
            radius: 16,
            controller: confirmPasswordController,
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
            onTap: () async {
              String name = nameController.text.trim();
              String username = usernameController.text.trim();
              String password = passwordController.text.trim();
              String confirmPassword = confirmPasswordController.text.trim();

              if (name.isNotEmpty &&
                  username.isNotEmpty &&
                  password.isNotEmpty &&
                  confirmPassword.isNotEmpty) {
                if (password == confirmPassword) {
                  // register
                  Map registerData =
                      await authController.register(name, username, password);

                  if (registerData['status'] == 'error') {
                    Get.snackbar(
                      "Register Error",
                      registerData['error'],
                      backgroundColor: const Color.fromRGBO(254, 101, 93, 1),
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    enrollmentService.restartFetch();
                    Get.back();
                  }
                } else {
                  // passwords error
                  Get.snackbar(
                    "Password Error",
                    "Passwords do not match.",
                    backgroundColor: const Color.fromRGBO(254, 101, 93, 1),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              } else {
                // empty fields
                Get.snackbar(
                  "Register Error",
                  "Please fill all the fields",
                  backgroundColor: const Color.fromRGBO(254, 101, 93, 1),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
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
                  widget.onSignInTap();
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
