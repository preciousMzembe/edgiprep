import 'package:edgiprep/views/components/home/home_study_subject.dart';
import 'package:edgiprep/views/components/home/home_study_topic.dart';
import 'package:edgiprep/views/components/home/home_study_topics_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget homeStudyBox(
  double boxWidth,
  Color background,
  String image,
  double imageHeight,
  double subjectFontSize,
  double topicFontSize,
  double topicsFontSize,
  double percent,
  double progressHeight,
  String subject,
  String topic,
  String topics,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Container(
      width: boxWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // subject image
          Container(
            padding: EdgeInsets.all(40.w),
            color: background,
            child: Center(
              child: Image.asset(
                "images/$image",
                height: imageHeight,
              ),
            ),
          ),

          // subject details
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 20.h,
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
                      child: homeStudyTopicsNumber(topics, topicsFontSize),
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
                        percent: percent.clamp(0.0, 1.0),
                        barRadius: Radius.circular(20.r),
                        backgroundColor: const Color.fromRGBO(234, 237, 244, 1),
                        progressColor: const Color.fromRGBO(73, 161, 249, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
