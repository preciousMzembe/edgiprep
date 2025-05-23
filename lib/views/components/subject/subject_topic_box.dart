import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/home/home_study_topics_number.dart';
import 'package:edgiprep/views/components/subject/subject_topic_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget subjectTopicBox(
  bool premium,
  bool active,
  String topic,
  String lessons,
  double percent,
  String subjectColor,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      // image
      double imageContainerWidth = isTablet
          ? 140.w
          : isSmallTablet
              ? 150.w
              : 160.w;

      double imageHeight = isTablet
          ? 44.h
          : isSmallTablet
              ? 46.h
              : 48.h;

      double verticalPadding = isTablet
          ? 34.h
          : isSmallTablet
              ? 32.h
              : 30.h;

      // topic
      double topicFontSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      double lessonsFontSize = isTablet
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

      // icon
      double iconHeight = isTablet
          ? 30.r
          : isSmallTablet
              ? 32.r
              : 34.r;

      // inactive
      double inactiveFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      // premium
      double premiumFontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return Stack(
        children: [
          // content
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (premium)
                SizedBox(
                  height: 25.h,
                ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  color: Colors.white,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        // subject image
                        Container(
                          width: imageContainerWidth,
                          color: premium
                              ? const Color.fromRGBO(249, 175, 73, 1)
                              : active
                                  ? getFadeColorFromString(subjectColor)
                                  : const Color.fromRGBO(214, 220, 233, 1),
                          child: Center(
                            child: Icon(
                              active
                                  ? FontAwesomeIcons.solidFileLines
                                  : FontAwesomeIcons.lock,
                              size: imageHeight,
                              color: premium
                                  ? Colors.white
                                  : active
                                      ? getColorFromString(subjectColor)
                                      : const Color.fromRGBO(141, 154, 176, 1),
                            ),
                          ),
                        ),

                        // subject details
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              vertical: verticalPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: active && !premium
                                          ? subjectTopicName(
                                              topic, topicFontSize)
                                          : premium
                                              ? Text(
                                                  "Get premium subscription to open",
                                                  style: GoogleFonts.inter(
                                                    fontSize: inactiveFontSize,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color.fromRGBO(
                                                        161, 168, 183, 1),
                                                  ),
                                                )
                                              : Text(
                                                  "Complete above topic to open",
                                                  style: GoogleFonts.inter(
                                                    fontSize: inactiveFontSize,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color.fromRGBO(
                                                        161, 168, 183, 1),
                                                  ),
                                                ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.angleRight,
                                      size: iconHeight,
                                      color: const Color.fromRGBO(
                                          161, 168, 183, 1),
                                    ),
                                  ],
                                ),

                                // inactive topic name
                                if (premium || !active)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      subjectTopicName(topic, topicFontSize),
                                    ],
                                  ),

                                // lessons and progress
                                if (!premium && active)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        children: [
                                          // topics
                                          Expanded(
                                            child: homeStudyTopicsNumber(
                                                lessons, lessonsFontSize),
                                          ),

                                          // progress
                                          SizedBox(
                                            width: 130.w,
                                            height: progressHeight,
                                            child: LinearPercentIndicator(
                                              width: 130.w,
                                              animation: true,
                                              animationDuration: 2000,
                                              lineHeight: progressHeight,
                                              percent: percent,
                                              barRadius: Radius.circular(20.r),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      234, 237, 244, 1),
                                              progressColor: getColorFromString(
                                                  subjectColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Premium
          if (premium)
            Positioned(
              top: 0.h,
              right: 80.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Container(
                  height: 50.h,
                  color: const Color.fromRGBO(249, 175, 73, 1),
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Premium",
                        style: GoogleFonts.inter(
                          fontSize: premiumFontSize,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
}
