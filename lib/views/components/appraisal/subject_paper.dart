import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget subjectPaper(
  Color progressColor,
  Color progresFadeColor,
  String name,
  int questions,
  String time,
  double score,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      // score progress

      double progressRadius = isTablet
          ? 50.sp
          : isSmallTablet
              ? 60.sp
              : 70.sp;

      double barWidth = isTablet
          ? 21.r
          : isSmallTablet
              ? 23.r
              : 25.r;

      double progressSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

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
          ? 44.h
          : isSmallTablet
              ? 46.h
              : 48.h;
      double iconSize = isTablet
          ? 22.h
          : isSmallTablet
              ? 24.h
              : 26.h;

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
              // score
              CircularPercentIndicator(
                radius: progressRadius,
                percent: score,
                progressColor: progressColor,
                lineWidth: barWidth,
                animationDuration: 2000,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: progresFadeColor,
                startAngle: 0,
                animation: true,
                center: Text(
                  "${(score * 100).toStringAsFixed(0)}%",
                  style: GoogleFonts.inter(
                    color: progressColor,
                    fontSize: progressSize,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              // details
              SizedBox(
                width: 30.w,
              ),
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
                      "$time hrs | $questions questions",
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
                    color: progresFadeColor,
                  ),
                  borderRadius: BorderRadius.circular(60.r),
                ),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.angleRight,
                    size: iconSize,
                    color: progressColor,
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
