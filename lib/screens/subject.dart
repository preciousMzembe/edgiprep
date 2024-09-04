import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/screens/topic.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Subject extends StatefulWidget {
  final Map subject;
  const Subject({super.key, required this.subject});

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  UserController userController = Get.find<UserController>();
  final ScrollController _controller = ScrollController();
  bool _showDetails = true;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(
              //   height: 30.h,
              // ),
              Container(
                color: primaryColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30.h,
                        left: 30.w,
                        right: 30.w,
                      ),
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
                                color: Colors.white,
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
                              widget.subject['subjectName'] ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // info
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 500),
                      crossFadeState: _showDetails
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
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
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            widget.subject['subjectImage']),
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
                                      widget.subject['subjectDescription'] ??
                                          "",
                                      maxLines: 3,
                                      style: GoogleFonts.nunito(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // topics
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: Container(
                                          color: Colors.white,
                                          width: 70.w,
                                          height: 70.w,
                                          child: Center(
                                            child: Text(
                                              "${userController.subjectsTopics[widget.subject['subjectId'].toString()]!.length}",
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
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              // progress
                              SizedBox(
                                height: 30.h,
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
                      secondChild: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 30.h,
                        ),
                        child: LinearPercentIndicator(
                          padding: const EdgeInsets.all(0),
                          animation: true,
                          lineHeight: 15.h,
                          animationDuration: 2000,
                          // percent
                          percent: .7,
                          barRadius: Radius.circular(30.r),
                          progressColor: Colors.white,
                          backgroundColor: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
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
                        ...userController.subjectsTopics[
                                widget.subject['subjectId'].toString()]
                            .map(
                              (topic) => Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SubjectTopic(
                                    topic: topic,
                                    percent: 0.4,
                                  ),
                                ],
                              ),
                            )
                            .toList(),

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
        ),
      );
    });
  }
}

class SubjectTopic extends StatelessWidget {
  final Map topic;
  final double percent;
  const SubjectTopic({
    super.key,
    required this.topic,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return GestureDetector(
      onTap: () {
        Get.to(() => Topic(
              topic: topic,
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.w,
          ),
          decoration: BoxDecoration(
            color: percent == 1
                ? const Color.fromARGB(255, 224, 229, 255)
                : const Color.fromARGB(255, 243, 245, 255),
            border: Border(
              left: BorderSide(
                width: 3,
                color: getRandomColor(topic['topicColor']),
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
                      topic['topicName'],
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${userController.topicsLessons[topic['topicId'].toString()].length} lessons",
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
                      progressColor: const Color.fromARGB(255, 66, 63, 63),
                      backgroundColor: const Color.fromARGB(255, 196, 196, 196),
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
