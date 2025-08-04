import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/services/enrollment/enrollment_service.dart';
import 'package:edgiprep/views/components/auth/auth_bottom_text.dart';
import 'package:edgiprep/views/components/auth/auth_rich_text.dart';
import 'package:edgiprep/views/components/auth/auth_title_dot.dart';
import 'package:edgiprep/views/components/auth/auth_input.dart';
import 'package:edgiprep/views/components/auth/auth_title_text.dart';
import 'package:edgiprep/views/components/general/button_loading.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
import 'package:edgiprep/views/components/general/pin_input_formatter.dart';
import 'package:edgiprep/views/components/general/username_input_formatter.dart';
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

  bool nameError = false;
  bool usernameError = false;
  bool passwordError = false;
  bool verifyPasswordError = false;

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

          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: nameError
                      ? const Color.fromARGB(255, 254, 101, 93)
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: AuthInput(
              label: "Full Name",
              type: TextInputType.name,
              isPassword: false,
              icon: FontAwesomeIcons.solidUser,
              radius: 16,
              controller: nameController,
            ),
          ),

          // email
          SizedBox(
            height: 25.h,
          ),
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
              formatter: UsernameInputFormatter(),
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
              label: "Pin",
              type: TextInputType.number,
              isPassword: true,
              icon: FontAwesomeIcons.lock,
              radius: 16,
              controller: passwordController,
              formatter: PinInputFormatter(),
            ),
          ),

          // confirm password
          SizedBox(
            height: 25.h,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: verifyPasswordError
                      ? const Color.fromARGB(255, 254, 101, 93)
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: AuthInput(
              label: "Confirm Pin",
              type: TextInputType.number,
              isPassword: true,
              icon: FontAwesomeIcons.lock,
              radius: 16,
              controller: confirmPasswordController,
              formatter: PinInputFormatter(),
            ),
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
          Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  if (!loginLoading && !googleLoading) {
                    changeLoginLoading();

                    nameError = false;
                    usernameError = false;
                    passwordError = false;
                    verifyPasswordError = false;

                    String name = nameController.text.trim();
                    String username = usernameController.text.trim();
                    String password = passwordController.text.trim();
                    String confirmPassword =
                        confirmPasswordController.text.trim();

                    if (name.isNotEmpty &&
                        username.isNotEmpty &&
                        password.isNotEmpty &&
                        confirmPassword.isNotEmpty) {
                      if (password == confirmPassword) {
                        if (username.length < 5) {
                          usernameError = true;
                          showSnackbar(
                              context,
                              "Something Went Wrong",
                              "Username should have 5 or more characters.",
                              true);
                        } else {
                          if (password.length < 4) {
                            passwordError = true;
                            showSnackbar(context, "Something Went Wrong",
                                "Pin should have 4 digits.", true);
                          } else {
                            // register
                            Map registerData = await authController.register(
                                name, username, password);

                            if (registerData['status'] == 'error') {
                              if (registerData['error'] ==
                                  "Username is already taken.") {
                                usernameError = true;
                                showSnackbar(context, "Something Went Wrong",
                                    registerData['error'], true);
                              } else {
                                showSnackbar(
                                    context,
                                    "Something Went Wrong",
                                    "There was a problem creating your account.",
                                    true);
                              }
                            } else {
                              enrollmentService.restartFetch();
                              Get.back();
                            }
                          }
                        }
                      } else {
                        // passwords error
                        verifyPasswordError = true;
                        showSnackbar(context, "Something Went Wrong",
                            "Pin does not match.", true);
                      }
                    } else {
                      // empty fields
                      if (name.isEmpty) {
                        nameError = true;
                      }

                      if (username.isEmpty) {
                        usernameError = true;
                      }

                      if (password.isEmpty) {
                        passwordError = true;
                      }

                      if (confirmPassword.isEmpty) {
                        verifyPasswordError = true;
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
          // SizedBox(
          //   height: 30.h,
          // ),

          // Text(
          //   "OR",
          //   textAlign: TextAlign.center,
          //   style: GoogleFonts.inter(
          //     fontSize: 22.sp,
          //     fontWeight: FontWeight.w700,
          //     color: const Color.fromRGBO(191, 198, 216, 1),
          //   ),
          // ),

          // // google
          // SizedBox(
          //   height: 30.h,
          // ),
          // Stack(
          //   children: [
          //     normalImageButton(
          //       unselectedButtonColor,
          //       Colors.black,
          //       "Continue with google",
          //       16,
          //       "icons/google.png",
          //     ),

          //     // loading
          //     if (googleLoading) buttonLoading(unselectedButtonColor, 16),
          //   ],
          // ),

          // login
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              authBottomText(
                "Already have an account?",
                const Color.fromRGBO(115, 115, 115, 1),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  if (!loginLoading && !googleLoading) {
                    widget.onSignInTap();
                  }
                },
                child: authBottomText(
                  "Sign In",
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
