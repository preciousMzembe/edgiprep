import 'package:edgiprep/auth/choose_exam.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: Image.asset("images/signup.png"),
              ),
              Text(
                "Let's Help You Setup Your Account",
                // textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 70.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                  "Creating an account is quick and easy. Let's get you set up so you can start accessing personalized study materials and track your progress."),
              const SizedBox(
                height: 40,
              ),
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
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const ChooseExam());
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
  }
}
