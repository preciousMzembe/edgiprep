import 'package:edgiprep/screens/start.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Topic extends StatefulWidget {
  const Topic({super.key});

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // back
                  SizedBox(
                    width: 75.h,
                    child: MaterialButton(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(75.r),
                      ),
                      height: 75.h,
                      onPressed: () {
                        Get.back();
                      },
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.white,
                          size: 25.h,
                        ),
                      ),
                    ),
                  ),
                  // subject
                  SizedBox(
                    width: 40.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Biology",
                          style: GoogleFonts.nunito(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "Plants Biology",
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Divider(
              height: 1,
              color: grayColor,
            ),

            // subjects
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (notification) {
                    final pixels = notification.metrics.pixels;
                    setState(() {
                      _showDetails = pixels <= 0; // hide or show to top button
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
                      // lessons
                      const Lesson(
                        lessonNumber: 1,
                        lessonName: "Flowering vs Nonflowering Plants",
                        lessonDescription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin.",
                        lessonDone: true,
                        currentLesson: false,
                        finalLesson: false,
                      ),
                      const Lesson(
                        lessonNumber: 2,
                        lessonName: "Parts of Flowering Plants",
                        lessonDescription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin.",
                        lessonDone: false,
                        currentLesson: true,
                        finalLesson: false,
                      ),
                      const Lesson(
                        lessonNumber: 3,
                        lessonName: "Parts of Nonflowering Plants",
                        lessonDescription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin.",
                        lessonDone: false,
                        currentLesson: false,
                        finalLesson: false,
                      ),
                      const Lesson(
                        lessonNumber: 4,
                        lessonName: "Plants Habitation",
                        lessonDescription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin.",
                        lessonDone: false,
                        currentLesson: false,
                        finalLesson: true,
                      ),
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
  final String lessonName;
  final String lessonDescription;
  final bool lessonDone;
  final bool currentLesson;
  final bool finalLesson;
  const Lesson(
      {super.key,
      required this.lessonNumber,
      required this.lessonName,
      required this.lessonDescription,
      required this.lessonDone,
      required this.currentLesson,
      required this.finalLesson});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30.h,
                height: 30.h,
                decoration: BoxDecoration(
                  color: currentLesson
                      ? primaryColor
                      : const Color.fromRGBO(47, 59, 98, 0.856),
                  // color: Color.fromRGBO(47, 59, 98, 1),
                  borderRadius: BorderRadius.circular(75.r),
                ),
              ),
              // line
              Expanded(
                child: Visibility(
                  visible: !finalLesson,
                  child: Container(
                    width: 6.w,
                    color: secondaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Column(
              children: [
                // name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (lessonDone) {
                            Get.to(() => const Start(
                                  testMode: TestMode.lesson,
                                  lessonDone: true,
                                ));
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Lesson $lessonNumber",
                                style: GoogleFonts.nunito(
                                  fontSize: 25.sp,
                                  color: textColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // lesson name
                              Text(
                                lessonName,
                                style: GoogleFonts.nunito(
                                  color: currentLesson
                                      ? Colors.black
                                      : Colors.black54,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // take lesson
                    // Visibility(
                    //   visible: lessonDone,
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 20.w,
                    //       ),
                    //       Icon(
                    //         FontAwesomeIcons.angleRight,
                    //         size: 30.h,
                    //         color: Colors.orange,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),

                // start box
                Visibility(
                  visible: currentLesson,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 40.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // descriptioin
                            Text(
                              lessonDescription,
                              style: GoogleFonts.nunito(
                                fontSize: 25.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            MaterialButton(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(700.r),
                              ),
                              height: 70.h,
                              onPressed: () {
                                Get.to(() =>
                                    const Start(testMode: TestMode.lesson));
                              },
                              child: Center(
                                child: Text(
                                  "Start",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // last space
                SizedBox(
                  height: currentLesson ? 80.h : 60.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
