import 'dart:ui';

import 'package:animated_visibility/animated_visibility.dart';
import 'package:edgiprep/start/start.dart';
import 'package:edgiprep/screens/topic.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Papers extends StatefulWidget {
  const Papers({super.key});

  @override
  State<Papers> createState() => _PapersState();
}

class _PapersState extends State<Papers> {
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
                      "Biology",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // info
            SizedBox(
              height: 20.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextField(
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  fillColor: grayColor,
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: 50.w,
                      right: 30.w,
                    ),
                    child: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Color.fromARGB(255, 139, 139, 139),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: grayColor,
                      // color: Color.fromARGB(255, 139, 139, 139),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: grayColor,
                      // color: Color.fromARGB(255, 139, 139, 139),
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Search',
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (notification) {
                    final pixels = notification.metrics.pixels;
                    setState(() {
                      _showDetails =
                          pixels <= 0; // Hide details when scrolled down
                    });
                    return true;
                  },
                  child: ListView(
                    controller: _controller,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Paper(
                        topic: "2013 MANEB",
                        color: getRandomColor(),
                        percent: .7,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Paper(
                        topic: "2023 Chaminade Mock Exam",
                        color: getRandomColor(),
                        percent: .3,
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

class Paper extends StatelessWidget {
  final String topic;
  final Color color;
  final double percent;
  const Paper({
    super.key,
    required this.topic,
    required this.color,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Start(
              testMode: TestMode.test,
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.w,
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 223, 226),
            border: Border(
              left: BorderSide(
                width: 5,
                color: color,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  topic
                    Text(
                      topic,
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "30 questions",
                      style: GoogleFonts.nunito(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    // // progress
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // LinearPercentIndicator(
                    //   padding: const EdgeInsets.all(0),
                    //   animation: true,
                    //   lineHeight: 10.h,
                    //   animationDuration: 2000,
                    //   // percent
                    //   percent: percent,
                    //   barRadius: Radius.circular(30.r),
                    //   progressColor: Colors.white,
                    //   backgroundColor: const Color.fromARGB(94, 255, 255, 255),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              // progress
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.h,
                    height: 70.h,
                    child: CircularPercentIndicator(
                      radius: 35.h,
                      percent: percent,
                      progressColor: primaryColor,
                      lineWidth: 3.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: progressColor,
                      startAngle: 270,
                      animation: true,
                      center: Text(
                        "${(percent * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Record",
                    style: GoogleFonts.nunito(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: Icon(
              //     FontAwesomeIcons.angleRight,
              //     size: 30.h,
              //     color: primaryColor,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseExam extends StatelessWidget {
  const ChooseExam({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 400.w,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 30.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Quiz",
                        style: GoogleFonts.nunito(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w900,
                          // color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Mock Exam",
                        style: GoogleFonts.nunito(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w900,
                          // color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Past Paper",
                        style: GoogleFonts.nunito(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w900,
                          // color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Challange",
                        style: GoogleFonts.nunito(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w900,
                          // color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
