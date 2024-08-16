import 'package:edgiprep/controllers/current_challange_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentChallangeController currentChallangeController =
        Get.find<CurrentChallangeController>();

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      Stack(
                        children: [
                          // box
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 600.w,
                                margin: EdgeInsets.only(top: 160.w),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 30.w,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 224, 229, 255),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 110.w,
                                    ),
                                    Text(
                                      currentChallangeController.score == 0
                                          ? "Better Luck Next Time"
                                          : "Congraturations",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunito(
                                        fontSize: 45.sp,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: GoogleFonts.nunito(
                                          color: Colors.black,
                                          fontSize: 35.sp,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "You have earned  ",
                                            style: GoogleFonts.nunito(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "+${currentChallangeController.score}  ",
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 35.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "XPs",
                                            style: GoogleFonts.nunito(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // image
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/done.png",
                                width: 400.w,
                                // color: primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // continue
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Container(
                      color: primaryColor,
                      height: 100.h,
                      child: Center(
                        child: Text(
                          "Finish",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
