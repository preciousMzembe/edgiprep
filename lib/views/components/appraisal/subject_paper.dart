import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget subjectPaper(
  String name,
  int questions,
  int duration,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      Duration time = Duration(minutes: duration);

      // Extract hours, minutes
      int hours = time.inHours;
      int minutes = time.inMinutes.remainder(60);

      // Format as a string
      String formattedTime = "";

      if (hours > 0) {
        formattedTime += "$hours hr${hours != 1 ? 's' : ''} ";
      }
      if (minutes > 0) {
        formattedTime += "$minutes min${minutes != 1 ? 's' : ''}";
      }

      // details

      double nameSize = isTablet
          ? 28.sp
          : isSmallTablet
              ? 30.sp
              : 32.sp;

      double textSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      // button
      double containerSize = isTablet
          ? 42.h
          : isSmallTablet
              ? 44.h
              : 46.h;
      double iconSize = isTablet
          ? 20.h
          : isSmallTablet
              ? 22.h
              : 24.h;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // name
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: nameSize,
                        fontWeight: FontWeight.w800,
                        color: const Color.fromRGBO(52, 74, 106, 1),
                      ),
                    ),

                    // text
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "$formattedTime | $questions question${questions != 1 ? 's' : ''}",
                      style: GoogleFonts.inter(
                        fontSize: textSize,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(161, 168, 183, 1),
                      ),
                    ),
                  ],
                ),
              ),
              // button
              SizedBox(
                width: 30.w,
              ),
              Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    width: 1.0,
                    color: const Color.fromRGBO(52, 74, 106, 1),
                  ),
                  borderRadius: BorderRadius.circular(60.r),
                ),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.angleRight,
                    size: iconSize,
                    color: const Color.fromRGBO(52, 74, 106, 1),
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
