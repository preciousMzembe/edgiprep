import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget logoutContent() => LayoutBuilder(builder: (context, constraints) {
      AuthController authController = Get.find<AuthController>();

      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 46.sp
          : isSmallTablet
              ? 48.sp
              : 50.sp;
      double subtitleFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: errorColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // icon
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.w,
                      vertical: 50.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: SvgPicture.asset(
                                'icons/sad.svg',
                                height: 130.r,
                                width: 130.r,
                              ),
                            ),
                          ],
                        ),

                        // title
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Confirm SignOut",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),

                        // subtitle
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Text(
                            "After you sign out you will need to sign in again after you open the App. ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 236, 236, 236),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // button
                  Container(
                    color: const Color.fromRGBO(254, 232, 232, 1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50.w,
                        vertical: 50.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: normalButton(
                                const Color.fromARGB(255, 161, 184, 231),
                                Colors.white,
                                "Cancel",
                                100,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await authController.logout();
                                Get.back();
                              },
                              child: normalButton(
                                const Color.fromARGB(255, 228, 131, 131),
                                Colors.white,
                                "SignOut",
                                100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
