import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget notificationBox(String title, String content, String time) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleSize = isTablet
          ? 22.sp
          : isSmallTablet
              ? 24.sp
              : 26.sp;

      double contentSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double timeSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double iconSize = isTablet
          ? 24.h
          : isSmallTablet
              ? 26.h
              : 28.h;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.all(35.r),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(103, 174, 255, 1),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    content,
                    style: GoogleFonts.inter(
                      fontSize: contentSize,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(92, 101, 120, 1),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.solidClock,
                        size: iconSize,
                        color: const Color.fromRGBO(193, 224, 255, 1),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Text(
                          time,
                          style: GoogleFonts.inter(
                            fontSize: timeSize,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(161, 168, 183, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // bottom space
          SizedBox(
            height: 30.h,
          ),
        ],
      );
    },
  );
}
