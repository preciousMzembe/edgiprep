import 'dart:ui';

import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showLogout(
  BuildContext context,
) {
  AuthController authController = Get.find<AuthController>();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = DeviceUtils.isTablet(context);
          bool isSmallTablet = DeviceUtils.isSmallTablet(context);

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

          double height = isTablet
              ? 80.sp
              : isSmallTablet
                  ? 84.h
                  : 84.h;

          double fontSize = isTablet
              ? 18.sp
              : isSmallTablet
                  ? 20.sp
                  : 24.sp;

          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                ),
              ),
              Center(
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        // image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'icons/sad_close.svg',
                              height: 155.r,
                              width: 155.r,
                            ),
                          ],
                        ),
                        // title
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          "Are You Sure You \nWant to SignOut?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(52, 74, 106, 1),
                          ),
                        ),

                        // text
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "After you sign out you will need to sign in again after you open the App.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(89, 89, 89, 1),
                          ),
                        ),

                        // button
                        SizedBox(
                          height: 40.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Container(
                              height: height,
                              color: const Color.fromRGBO(35, 131, 226, 1),
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: Center(
                                child: Text(
                                  "No, Cancel",
                                  style: GoogleFonts.inter(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await authController.logout();
                            Get.back();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Container(
                              height: height,
                              color: const Color.fromRGBO(236, 239, 245, 1),
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: Center(
                                child: Text(
                                  "Yes, SignOut",
                                  style: GoogleFonts.inter(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromRGBO(52, 74, 106, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
