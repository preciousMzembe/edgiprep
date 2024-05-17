import 'package:edgiprep/screens/topic.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                    child: Text(
                      "Biology",
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
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              crossFadeState: _showDetails
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin. Nam vitae sapien euismod, molestie velit a, viverra libero. Cras in diam feugiat, efficitur lacus non, vehicula velit.",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: Container(),
            ),

            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: LinearPercentIndicator(
                padding: const EdgeInsets.all(0),
                animation: true,
                lineHeight: 25.h,
                animationDuration: 2000,
                // percent
                percent: .7,
                barRadius: Radius.circular(30.r),
                progressColor: primaryColor,
                backgroundColor: progressColor,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Divider(
              height: 1.h,
              color: grayColor,
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
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
                      const SubjectTopic(
                        topic: "Research skills",
                        percent: .4,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const SubjectTopic(
                        topic: "Plant Biology",
                        percent: .8,
                      ),

                      SizedBox(
                        height: 50.h,
                      ),
                      LinearPercentIndicator(
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        animation: true,
                        lineHeight: 120.h,
                        animationDuration: 2000,
                        // percent
                        percent: .0,
                        barRadius: Radius.circular(40.r),
                        progressColor: Colors.white,
                        // progressColor: Color.fromRGBO(47, 59, 98, 1),
                        backgroundColor: Color.fromRGBO(255, 249, 249, 1),
                        center: Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                // color: Color.fromRGBO(255, 255, 255, 0),
                                // color: Color.fromRGBO(47, 59, 98, 0.767),
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Plant Biology ",
                                        style: GoogleFonts.nunito(
                                          fontSize: 35.sp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Icon(
                                        FontAwesomeIcons.anglesRight,
                                        size: 30.h,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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

class SubjectTopic extends StatefulWidget {
  final String topic;
  final double percent;
  const SubjectTopic({super.key, required this.topic, required this.percent});

  @override
  State<SubjectTopic> createState() => _SubjectTopicState();
}

class _SubjectTopicState extends State<SubjectTopic> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MaterialButton(
          onPressed: () {
            Get.to(() => const Topic());
          },
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 40.h,
            vertical: 40.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  topic
                        Text(
                          widget.topic,
                          style: GoogleFonts.nunito(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Icon(
                      FontAwesomeIcons.anglesRight,
                      size: 30.h,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: LinearPercentIndicator(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            animation: true,
            lineHeight: 2.h,
            animationDuration: 2000,
            // percent
            percent: widget.percent,
            barRadius: Radius.circular(30.r),
            progressColor: primaryColor,
            backgroundColor: secondaryColor,
          ),
        ),
      ],
    );
  }
}
