import 'package:edgiprep/controllers/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class SetPin extends StatefulWidget {
  const SetPin({super.key});

  @override
  State<SetPin> createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  AuthController authController = Get.find<AuthController>();
  late TextEditingController pinController;
  late TextEditingController verifyPinController;
  late FocusNode focusNode;
  late FocusNode verifyFocusNode;

  @override
  void initState() {
    super.initState();

    pinController = TextEditingController();
    pinController.text = authController.pin;
    verifyPinController = TextEditingController();
    verifyPinController.text = authController.verifyPin;
    focusNode = FocusNode();
    verifyFocusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    verifyPinController.dispose();
    focusNode.dispose();
    verifyFocusNode.dispose();
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
    return LayoutBuilder(builder: (context, constants) {
      // final isTall = constants.maxHeight > constants.maxWidth;
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
                          "Set Your \nPin",
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 70.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                            "Secure your account with a personalized PIN."),
                        const SizedBox(
                          height: 40,
                        ),

                        // pin
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
                                  padding: const EdgeInsets.all(8),
                                  color:
                                      const Color.fromRGBO(244, 67, 54, 0.223),
                                  child: const Center(
                                    child: Text(
                                      "pins do not match",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                      if (authController.pin.length == 4 &&
                          authController.verifyPin.length == 4)
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              showLoadingDialog(context, "Creating Account",
                                  "Please wait while we are creating your account.");

                              // TODO: remove delay
                              await Future.delayed(const Duration(seconds: 3));
                              Navigator.pop(context);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.r),
                              child: Container(
                                color: primaryColor,
                                height: 95.h,
                                child: Center(
                                  child: Text(
                                    "Create Account",
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
