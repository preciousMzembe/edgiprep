import 'package:edgiprep/auth/set_pin.dart';
import 'package:edgiprep/controllers/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class SetUsername extends StatefulWidget {
  const SetUsername({super.key});

  @override
  State<SetUsername> createState() => _SetUsernameState();
}

class _SetUsernameState extends State<SetUsername> {
  AuthController authController = Get.find<AuthController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  late TextEditingController pinController;
  late TextEditingController verifyPinController;
  late FocusNode focusNode;
  late FocusNode verifyFocusNode;

  @override
  void initState() {
    super.initState();

    _controller.text = authController.username;
    _nameController.text = authController.fullName;

    pinController = TextEditingController();
    pinController.text = authController.pin;
    verifyPinController = TextEditingController();
    verifyPinController.text = authController.verifyPin;
    focusNode = FocusNode();
    verifyFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _nameController.dispose();

    pinController.dispose();
    verifyPinController.dispose();
    focusNode.dispose();
    verifyFocusNode.dispose();
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

    return LayoutBuilder(builder: (context, constants) {
      final isTall = constants.maxHeight > constants.maxWidth;

      return Obx(() {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Finish Setting Up \nYour Account",
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 70.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                            "Choose a username that represents you. This will be your unique identifier within the EdgiPrep community."),
                        const SizedBox(
                          height: 40,
                        ),

                        // full name
                        const Text("Full Name"),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: _nameController,
                          onChanged: (value) {
                            authController
                                .setFullName(_nameController.text.trim());
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

                        // username
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Username"),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: _controller,
                          onChanged: (value) {
                            authController.setUsername(_controller.text.trim());
                          },
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            fillColor: grayColor,
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

                        // Pin
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
                              obscureText: authController.hideSignPin.value,
                              controller: pinController,
                              focusNode: focusNode,
                              defaultPinTheme: defaultPinTheme,
                              separatorBuilder: (index) =>
                                  const SizedBox(width: 8),
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              onChanged: (value) {
                                authController
                                    .setPin(pinController.text.trim());
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
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(color: focusedBorderColor),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
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
                                authController.hideSignPin.value =
                                    !authController.hideSignPin.value;
                              },
                              child: Icon(
                                authController.hideSignPin.value
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),

                        // verify pin
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Verify Pin"),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Pinput(
                              obscureText: authController.hideVerifyPin.value,
                              controller: verifyPinController,
                              focusNode: verifyFocusNode,
                              defaultPinTheme: defaultPinTheme,
                              separatorBuilder: (index) =>
                                  const SizedBox(width: 8),
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              onChanged: (value) {
                                authController.setVerifyPin(
                                    verifyPinController.text.trim());
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
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(color: focusedBorderColor),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
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
                                authController.hideVerifyPin.value =
                                    !authController.hideVerifyPin.value;
                              },
                              child: Icon(
                                authController.hideVerifyPin.value
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),

                        // Error -------------------------

                        if (authController.nameError.value)
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
                                  color:
                                      const Color.fromRGBO(244, 67, 54, 0.223),
                                  child: Center(
                                    child: Text(
                                      authController.nameErrorMessage.value,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        if (authController.signPinError.value)
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
                                  color:
                                      const Color.fromRGBO(244, 67, 54, 0.223),
                                  child: const Center(
                                    child: Text(
                                      "Pins do not match",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        // Bottom
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),

                  //back
                  Row(
                    children: [
                      // back
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: Container(
                            color: grayColor,
                            height: 95.h,
                            width: 95.h,
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.arrowLeft,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // continue
                      const SizedBox(
                        width: 20,
                      ),
                      if (authController.fullName != "" &&
                          authController.username.length >= 5 &&
                          authController.pin.length == 4 &&
                          authController.verifyPin.length == 4)
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              authController.nameError.value = false;
                              authController.signPinError.value = false;
                              if (authController.pin !=
                                  authController.verifyPin) {
                                authController.signPinError.value = true;
                              } else {
                                showLoadingDialog(context, "Creating Account",
                                    "Please wait while we are creating your account.");

                                bool done = await authController.register();

                                if (done) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
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
                                    "Continue",
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
                        ),
                    ],
                  ),
                  // bottom
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
