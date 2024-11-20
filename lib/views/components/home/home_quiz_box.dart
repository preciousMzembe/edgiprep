import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget homeQuizBox(
  double boxWidth,
  String image,
  double imageContainerHeight,
  double imageHeight,
  double subjectFontSize,
  double questionsFontSize,
  String subject,
  String questions,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(40.w),
      width: boxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  width: imageContainerHeight,
                  height: imageContainerHeight,
                  color: homeLightBackgroundColor,
                  child: Center(
                    child: SvgPicture.asset(
                      'icons/$image',
                      height: imageHeight,
                      width: imageHeight,
                      colorFilter:
                          ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              Container(
                width: imageContainerHeight,
                height: imageContainerHeight,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      FontAwesomeIcons.angleRight,
                      size: imageHeight,
                      color: const Color.fromRGBO(161, 168, 183, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // name
          SizedBox(
            height: 25.h,
          ),
          Text(
            subject,
            style: GoogleFonts.inter(
              fontSize: subjectFontSize,
              fontWeight: FontWeight.w800,
              color: const Color.fromRGBO(52, 74, 106, 1),
            ),
          ),

          // questions and time
          SizedBox(
            height: 8.h,
          ),
          Text(
            questions,
            style: GoogleFonts.inter(
              fontSize: questionsFontSize,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(161, 168, 183, 1),
            ),
          ),
        ],
      ),
    ),
  );
}
