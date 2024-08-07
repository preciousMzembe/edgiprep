import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/start/start_lesson.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Topic extends StatefulWidget {
  final Map topic;
  const Topic({super.key, required this.topic});

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  UserController userController = Get.find<UserController>();
  final ScrollController _controller = ScrollController();
  bool _showDetails = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // back
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      color: Colors.transparent,
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: primaryColor,
                        size: 40.w,
                      ),
                    ),
                  ),
                  // subject
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.topic['topicName']}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              height: 1.h,
              color: const Color.fromARGB(48, 158, 158, 158),
            ),

            // lessons
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (notification) {
                    final pixels = notification.metrics.pixels;
                    setState(() {
                      _showDetails = pixels <= 0;
                    });
                    return true;
                  },
                  child: ListView(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      ...userController.topicsLessons[widget.topic['topicId']]
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        var lesson = entry.value;
                        return Lesson(
                          lessonNumber: index + 1,
                          lessonId: lesson['lessonId'],
                          lessonName: lesson['lessonName'],
                          lessonDone: lesson['lessonDone'] ?? false,
                          currentLesson: index == 0
                              ? true
                              : lesson['currentLesson'] ?? false,
                          finalLesson: lesson['finalLesson'] ?? false,
                        );
                      }).toList(),
                      // back to top
                      SizedBox(
                        height: 90.h,
                      ),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 10),
                        crossFadeState: _showDetails
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Container(),
                        secondChild: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 75.h,
                              child: MaterialButton(
                                color: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(75.r),
                                ),
                                height: 75.h,
                                onPressed: () {
                                  _controller.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.arrowUp,
                                    color: Colors.white,
                                    size: 25.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Lesson extends StatelessWidget {
  final int lessonNumber;
  final int lessonId;
  final String lessonName;
  final bool lessonDone;
  final bool currentLesson;
  final bool finalLesson;
  const Lesson(
      {super.key,
      required this.lessonNumber,
      required this.lessonName,
      required this.lessonDone,
      required this.currentLesson,
      required this.finalLesson,
      required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: !currentLesson ? 10.h : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: !currentLesson,
                  child: Container(
                    width: 30.h,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75.r),
                      border: Border.all(width: 2.0, color: primaryColor),
                    ),
                  ),
                ),
                Visibility(
                  visible: currentLesson,
                  child: Container(
                    width: 50.h,
                    height: 50.h,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75.r),
                      border: Border.all(width: 2.0, color: primaryColor),
                    ),
                    child: ClipOval(
                      child: Container(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // line
                Expanded(
                  child: Visibility(
                    visible: true,
                    // visible: !finalLesson,
                    child: Container(
                      width: 2.0,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // name
                GestureDetector(
                  onTap: () {
                    if (lessonDone) {
                      Get.to(() => StartLesson(
                            topic: lessonName,
                            lessonDone: lessonDone,
                            lessonId: lessonId,
                          ));
                    }

                    if (currentLesson) {
                      Get.to(() => StartLesson(
                            topic: lessonName,
                            lessonDone: false,
                            lessonId: lessonId,
                          ));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(30.w),
                    decoration: BoxDecoration(
                      color: currentLesson
                          ? primaryColor
                          : lessonDone
                              ? const Color.fromARGB(255, 224, 229, 255)
                              : const Color.fromRGBO(248, 249, 253, 1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Lesson $lessonNumber",
                          style: GoogleFonts.nunito(
                            fontSize: 25.sp,
                            color: currentLesson ? Colors.white : textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // lesson name
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          lessonName,
                          style: GoogleFonts.nunito(
                            color: currentLesson ? Colors.white : Colors.black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // last space
                SizedBox(
                  // height: 50.h,
                  height: finalLesson ? 30.h : 50.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
