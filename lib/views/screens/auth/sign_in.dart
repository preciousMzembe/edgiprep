import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_title_comma.dart';
import 'package:edgiprep/views/components/auth/auth_input.dart';
import 'package:edgiprep/views/components/auth/auth_title_text.dart';
import 'package:edgiprep/views/components/general/button_loading.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/general/normal_image_button.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onSignUpTap;
  const SignIn({
    super.key,
    required this.onSignUpTap,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthController authController = Get.find<AuthController>();
  EnrollmentService enrollmentService = Get.find<EnrollmentService>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool usernameError = false;
  bool passwordError = false;

  bool loginLoading = false;
  bool googleLoading = false;

  void changeLoginLoading() {
    setState(() {
      loginLoading = !loginLoading;
    });
  }

  void changeGoogleLoading() {
    setState(() {
      googleLoading = !googleLoading;
    });
  }

  @override
  dispose() {
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: usernameError
                      ? const Color.fromARGB(255, 254, 101, 93)
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: AuthInput(
              label: "Username",
              type: TextInputType.text,
              isPassword: false,
              icon: FontAwesomeIcons.solidUser,
              radius: 16,
              controller: usernameController,
            ),
          ),

          // password
          SizedBox(
            height: 25.h,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: passwordError
                      ? const Color.fromARGB(255, 254, 101, 93)
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: AuthInput(
              label: "Password",
              type: TextInputType.text,
              isPassword: true,
              icon: FontAwesomeIcons.lock,
              radius: 16,
              controller: passwordController,
            ),
          ),

          // continue
          SizedBox(
            height: 35.h,
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  if (!loginLoading && !googleLoading) {
                    changeLoginLoading();

                    usernameError = false;
                    passwordError = false;

                    String username = usernameController.text.trim();
                    String password = passwordController.text.trim();

                    if (username.isNotEmpty && password.isNotEmpty) {
                      Map loginData =
                          await authController.login(username, password);

                      if (loginData['status'] == 'error') {
                        Get.snackbar(
                          "Login Error",
                          loginData['error'],
                          backgroundColor:
                              const Color.fromRGBO(254, 101, 93, 1),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        // get enrollment data
                        enrollmentService.restartFetch();
                        Get.back();
                      }
                    } else {
                      if (username.isEmpty) {
                        usernameError = true;
                      }

                      if (password.isEmpty) {
                        passwordError = true;
                      }
                    }

                    changeLoginLoading();
                  }
                },
                child: normalButton(
                  primaryColor,
                  Colors.white,
                  "Continue",
                  16,
                ),
              ),

              // loading
              if (loginLoading) buttonLoading(unselectedButtonColor, 16),
            ],
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
          Stack(
            children: [
              normalImageButton(
                unselectedButtonColor,
                Colors.black,
                "Continue with google",
                16,
                "icons/google.png",
              ),

              // loading
              if (googleLoading) buttonLoading(unselectedButtonColor, 16),
            ],
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
                  if (!loginLoading && !googleLoading) {
                    widget.onSignUpTap();
                  }
                },
                child: authBottomText(
                  "Sign Up",
                  loginLoading || googleLoading
                      ? const Color.fromRGBO(115, 115, 115, 1)
                      : primaryColor,
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
