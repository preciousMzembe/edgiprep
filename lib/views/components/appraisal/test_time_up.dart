import 'dart:ui';

import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/screens/appraisal/appraisal_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget testTimeUp(
  BuildContext context,
  String type,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageHeight = isTablet
          ? 260.h
          : isSmallTablet
              ? 280.h
              : 200.h;

      double titleFontSize = isTablet
          ? 32.sp
          : isSmallTablet
              ? 34.sp
              : 36.sp;

      double subtitleFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      double buttonHeight = isTablet
          ? 80.sp
          : isSmallTablet
              ? 84.h
              : 84.h;

      double buttonFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 24.sp;

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(60.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // image
                        Container(
                          color: const Color.fromRGBO(240, 241, 254, 1),
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: Image.asset(
                            'images/timeup.png',
                            height: imageHeight,
                          ),
                        ),

                        // body
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 40.h,
                            horizontal: 50.w,
                          ),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text(
                                "Time Up!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(52, 74, 106, 1),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "You've reached the end of the allotted time for this test. Your answers have been submitted automatically. Let's see how you did!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: subtitleFontSize,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(52, 74, 106, 1),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (type == "paper") {
                                    Get.to(() => const AppraisalFinish(
                                          type: "paper",
                                        ));
                                  } else if (type == "mock") {
                                    Get.to(() => const AppraisalFinish(
                                          type: "mock",
                                        ));
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Container(
                                    height: buttonHeight,
                                    color:
                                        const Color.fromRGBO(35, 131, 226, 1),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50.w),
                                    child: Center(
                                      child: Text(
                                        "See Results",
                                        style: GoogleFonts.inter(
                                          fontSize: buttonFontSize,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
