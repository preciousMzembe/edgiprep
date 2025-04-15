import 'package:cached_network_image/cached_network_image.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/home/home_study_subject.dart';
import 'package:edgiprep/views/components/home/home_study_topic.dart';
import 'package:edgiprep/views/components/home/home_study_topics_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget subjectsSubjectBox(
  Color background,
  String image,
  String subject,
  String topic,
  String topics,
  double percent,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageContainerWidth = isTablet
          ? 180.w
          : isSmallTablet
              ? 210.w
              : 240.w;

      double imageHeight = isTablet
          ? 110.h
          : isSmallTablet
              ? 90.h
              : 90.h;

      double verticalPadding = isTablet
          ? 24.h
          : isSmallTablet
              ? 22.h
              : 20.h;

      double subjectFontSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double topicFontSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      double topicsFontSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      double progressHeight = isTablet
          ? 10.h
          : isSmallTablet
              ? 12.h
              : 14.h;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: Colors.white,
          child: IntrinsicHeight(
            child: Row(
              children: [
                // subject image
                Container(
                  width: imageContainerWidth,
                  color: background,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: image,
                      height: imageHeight,
                      placeholder: (context, url) => Center(
                        child: Lottie.asset(
                          'icons/white_loading.json',
                          height: imageHeight,
                          fit: BoxFit.fill,
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "images/subject.png",
                        height: imageHeight,
                      ),
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
                        // name
                        homeStudySubject(subject, subjectFontSize),

                        // topic
                        SizedBox(
                          height: 20.h,
                        ),
                        homeStudyTopic(topic, topicFontSize),

                        // topics and progress
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            // topics
                            Expanded(
                              child:
                                  homeStudyTopicsNumber(topics, topicsFontSize),
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
                                    const Color.fromRGBO(234, 237, 244, 1),
                                progressColor:
                                    const Color.fromRGBO(73, 161, 249, 1),
                              ),
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
      );
    },
  );
}
