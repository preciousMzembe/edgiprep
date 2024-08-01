import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController pinController;
  late TextEditingController verifyPinController;
  late FocusNode focusNode;
  late FocusNode verifyFocusNode;

  @override
  void initState() {
    super.initState();

    pinController = TextEditingController();
    verifyPinController = TextEditingController();
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
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: ListView(
                children: [
                  // back
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // back
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          color: Colors.transparent,
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 40.w,
                          ),
                        ),
                      ),
                    ],
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
                    // child: Text(
                    //   "EdgiPrep",
                    //   style: GoogleFonts.nunito(
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.w900,
                    //   ),
                    // ),
                  ),
                  // form
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Sign Up",
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
                      // hintStyle: TextStyle(
                      //   fontSize: isTall ? 30.sp : 15.sp,
                      // ),
                      // hintText: 'Username',
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
                        obscureText: true,
                        controller: pinController,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
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
                        // preFilledWidget: const Text(
                        //   'PIN',
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                      ),
                    ],
                  ),

                  // password
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
                        obscureText: true,
                        controller: verifyPinController,
                        focusNode: verifyFocusNode,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
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
                        // preFilledWidget: const Text(
                        //   'PIN',
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                      ),
                    ],
                  ),

                  // signin button
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.r),
                    child: Container(
                      color: primaryColor,
                      height: 95.h,
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
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
      },
    );
  }
}
