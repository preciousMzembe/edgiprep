import 'package:edgiprep/auth/get_started.dart';
import 'package:edgiprep/controllers/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  AuthController authController = Get.find<AuthController>();
  final TextEditingController _nameController = TextEditingController();
  late TextEditingController pinController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color focusedBorderColor = primaryColor;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    Color borderColor = primaryColor;
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: primaryColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: borderColor),
      ),
    );
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;
        return Obx(() {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),

                    // logo
                    Center(
                      child: ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          color: const Color.fromRGBO(47, 59, 98, 0.223),
                          child: Center(
                            child: Image.asset(
                              "icons/logo.png",
                              height: 40,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // form
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Sign In",
                      style: GoogleFonts.nunito(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    // username
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Username"),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _nameController,
                      onChanged: (value) {
                        authController.logUsername.value =
                            _nameController.text.trim();
                      },
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        fillColor: grayColor,
                        // filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: isTall ? 25.h : 35.h,
                          horizontal: isTall ? 50.w : 25.w,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: isTall ? 30.sp : 15.sp,
                      ),
                    ),

                    // password
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Pin"),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Pinput(
                          obscureText: authController.hideLogPin.value,
                          controller: pinController,
                          focusNode: focusNode,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onChanged: (value) {
                            authController.logPin.value =
                                pinController.text.trim();
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),

                        // view pin
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            authController.hideLogPin.value =
                                !authController.hideLogPin.value;
                          },
                          child: Icon(
                            authController.hideLogPin.value
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    if (authController.logError.value)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              color: const Color.fromRGBO(244, 67, 54, 0.223),
                              child: Center(
                                child: Text(
                                  authController.logErrorMessage.value,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    // signin button
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (authController.logUsername.isNotEmpty &&
                            authController.logPin.isNotEmpty) {
                          authController.logError.value = false;

                          showLoadingDialog(context, "Processing Data",
                              "Please wait while we verify your credentials.");

                          // login
                          await authController.login();

                          Navigator.pop(context);
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child: Container(
                          color: primaryColor,
                          height: 95.h,
                          child: Center(
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // sign up
                    const SizedBox(
                      height: 40,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                        ),
                        text: "Do not have an Account? ",
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: GoogleFonts.nunito(
                              color: primaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                authController.resetController();
                                Get.to(() => const GetStarted());
                              },
                          ),
                        ],
                      ),
                    ),

                    // bottom
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
