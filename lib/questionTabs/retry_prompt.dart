import 'package:edgiprep/questionTabs/done.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RetryPrompt extends StatefulWidget {
  const RetryPrompt({super.key});

  @override
  State<RetryPrompt> createState() => _RetryPromptState();
}

class _RetryPromptState extends State<RetryPrompt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // body
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // image
                    Image.asset(
                      "images/learn2.png",
                      width: 400.w,
                      // color: primaryColor,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Lets Make Corrections",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              // continue
              MaterialButton(
                color: secondaryColor,
                height: 100.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                onPressed: () {
                  Get.to(() => const Done());
                },
                child: Text(
                  "Continue",
                  style: GoogleFonts.nunito(
                    color: primaryColor,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
