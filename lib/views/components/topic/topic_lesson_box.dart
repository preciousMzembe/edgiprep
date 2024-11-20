import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/topic/topic_complete_text.dart';
import 'package:edgiprep/views/components/topic/topic_lesson_name.dart';
import 'package:edgiprep/views/components/topic/topic_lesson_number.dart';
import 'package:edgiprep/views/components/topic/topic_slides_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

Widget topicLessonBox(
  int lessonNumber,
  bool active,
  bool done,
  bool isFirst,
  bool isLast,
  String name,
  String slides,
  double percent,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      // indicator
      double indicatorNumberFontSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      // complete
      double completeFontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      // topic number
      double lessonNumberFontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      // topic lesson name
      double topicLessonFontSize = isTablet
          ? 22.sp
          : isSmallTablet
              ? 26.sp
              : 28.sp;

      // slides number
      double slidesFontSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      // progress
      double progressHeight = isTablet
          ? 10.h
          : isSmallTablet
              ? 12.h
              : 14.h;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // indicator
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // top line
                  if (isFirst)
                    SizedBox(
                      height: 6.h,
                    ),
                  if (!isFirst)
                    Container(
                      width: 0,
                      height: 6.h,
                      decoration: BoxDecoration(
                        border: RDottedLineBorder(
                            left: BorderSide(
                          color: active
                              ? const Color.fromRGBO(112, 180, 248, 1)
                              : const Color.fromRGBO(161, 168, 183, 1),
                        )),
                      ),
                    ),

                  // number
                  Container(
                    height: 68.r,
                    width: 68.r,
                    decoration: BoxDecoration(
                      color: done
                          ? Colors.transparent
                          : active
                              ? const Color.fromRGBO(112, 180, 248, 1)
                              : const Color.fromRGBO(161, 168, 183, 1),
                      border: Border.all(
                        width: 1.0,
                        color: active
                            ? const Color.fromRGBO(112, 180, 248, 1)
                            : const Color.fromRGBO(161, 168, 183, 1),
                      ),
                      borderRadius: BorderRadius.circular(60.r),
                    ),
                    child: Center(
                      child: done
                          ? Icon(
                              FontAwesomeIcons.check,
                              color: const Color.fromRGBO(112, 180, 248, 1),
                              size: 25.r,
                            )
                          : active
                              ? Text(
                                  lessonNumber.toString(),
                                  style: GoogleFonts.inter(
                                    fontSize: indicatorNumberFontSize,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  FontAwesomeIcons.lock,
                                  size: 25.r,
                                  color: Colors.white,
                                ),
                    ),
                  ),

                  // bottom line
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 0,
                        decoration: BoxDecoration(
                          border: RDottedLineBorder(
                              left: BorderSide(
                            color: active
                                ? const Color.fromRGBO(112, 180, 248, 1)
                                : const Color.fromRGBO(161, 168, 183, 1),
                          )),
                        ),
                      ),
                    ),
                ],
              ),

              // Content
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 30.h,
                          horizontal: 35.w,
                        ),
                        color: done
                            ? const Color.fromRGBO(215, 235, 255, 1)
                            : Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // complete
                            if (!active)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  topicCompleteText(
                                      "Complete above lesson to open",
                                      completeFontSize),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                ],
                              ),

                            // lesson number
                            topicLessonNumber(
                                "Lesson $lessonNumber", lessonNumberFontSize),

                            // title
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              crossAxisAlignment: active
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: topicLessonName(
                                      name, topicLessonFontSize),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Icon(
                                  FontAwesomeIcons.angleRight,
                                  size: 35.r,
                                  color: const Color.fromRGBO(161, 168, 183, 1),
                                ),
                              ],
                            ),

                            // progress
                            if (active)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      topicSlidesNumber(
                                        slides,
                                        const Color.fromRGBO(161, 168, 183, 1),
                                        slidesFontSize,
                                      ),
                                      LinearPercentIndicator(
                                        width: 130.w,
                                        animation: true,
                                        animationDuration: 2000,
                                        lineHeight: progressHeight,
                                        percent: percent,
                                        barRadius: Radius.circular(20.r),
                                        backgroundColor: const Color.fromRGBO(
                                            234, 237, 244, 1),
                                        progressColor: const Color.fromRGBO(
                                            73, 161, 249, 1),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),

                    // bottom
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
