import 'dart:ui';

import 'package:animated_visibility/animated_visibility.dart';
import 'package:edgiprep/screens/topic.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Subject extends StatefulWidget {
  const Subject({super.key});

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  final ScrollController _controller = ScrollController();
  bool _showDetails = true;

  bool _chooseExam = false;

  void changeChooseExam() {
    setState(() {
      _chooseExam = !_chooseExam;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // page info
            Column(
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
                      // image
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: changeChooseExam,
                        child: Container(
                          color: Colors.transparent,
                          width: 50.h,
                          height: 50.h,
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.ellipsisVertical,
                              size: 35.h,
                            ),
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
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: _showDetails
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 30.w,
                        ),
                        color: progressColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // image, details and topics
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // image
                                Container(
                                  width: 70.h,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('images/biology.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),

                                // details
                                SizedBox(
                                  width: 25.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin. Na",
                                    style: GoogleFonts.nunito(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                                // topics
                                SizedBox(
                                  width: 25.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Container(
                                        color: Colors.white,
                                        width: 70.w,
                                        height: 70.w,
                                        child: Center(
                                          child: Text(
                                            "2",
                                            style: GoogleFonts.nunito(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w800,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "Topics",
                                      style: GoogleFonts.nunito(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            // progress
                            SizedBox(
                              height: 20.h,
                            ),
                            LinearPercentIndicator(
                              padding: const EdgeInsets.all(0),
                              animation: true,
                              lineHeight: 15.h,
                              animationDuration: 2000,
                              // percent
                              percent: .7,
                              barRadius: Radius.circular(30.r),
                              progressColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(94, 255, 255, 255),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  secondChild: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      animation: true,
                      lineHeight: 15.h,
                      animationDuration: 2000,
                      // percent
                      percent: .7,
                      barRadius: Radius.circular(30.r),
                      progressColor: primaryColor,
                      backgroundColor: progressColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Divider(
                  height: 1.h,
                  color: const Color.fromARGB(48, 158, 158, 158),
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
                          SubjectTopic(
                            topic: "Research skills",
                            color: getRandomColor(),
                            percent: .7,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SubjectTopic(
                            topic: "Plant Biology",
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
                                        duration:
                                            const Duration(milliseconds: 500),
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
            // choose exam
            AnimatedVisibility(
              visible: _chooseExam,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: GestureDetector(
                  onTap: () {
                    changeChooseExam();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 70.w,
                      vertical: 90.h,
                    ),
                    color: const Color.fromARGB(29, 47, 59, 98),
                    child: const ChooseExam(),
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

class SubjectTopic extends StatelessWidget {
  final String topic;
  final Color color;
  final double percent;
  const SubjectTopic({
    super.key,
    required this.topic,
    required this.color,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Topic());
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
                      "3 lessons",
                      style: GoogleFonts.nunito(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    // progress
                    SizedBox(
                      height: 20.h,
                    ),
                    LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      animation: true,
                      lineHeight: 10.h,
                      animationDuration: 2000,
                      // percent
                      percent: percent,
                      barRadius: Radius.circular(30.r),
                      progressColor: Colors.white,
                      backgroundColor: const Color.fromARGB(94, 255, 255, 255),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Center(
                child: Icon(
                  FontAwesomeIcons.angleRight,
                  size: 30.h,
                  color: primaryColor,
                ),
              ),
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
                        "Mock Test",
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
