import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/loading_content.dart';
import 'package:edgiprep/views/components/general/no_data_content.dart';
import 'package:edgiprep/views/components/subjects/subjects_back.dart';
import 'package:edgiprep/views/components/topic/topic_lesson_box.dart';
import 'package:edgiprep/views/components/topic/topic_lessons_number.dart';
import 'package:edgiprep/views/components/topic/topic_quiz_button.dart';
import 'package:edgiprep/views/components/topic/topic_topic_name.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubjectTopic extends StatefulWidget {
  final UserSubject subject;
  final Topic topic;
  const SubjectTopic({
    super.key,
    required this.subject,
    required this.topic,
  });

  @override
  State<SubjectTopic> createState() => _SubjectTopicState();
}

class _SubjectTopicState extends State<SubjectTopic> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();

  bool loading = true;
  List<Lesson> lessons = [];
  double topicPercent = 0;

  Future<void> _fetchTopicLessons() async {
    var data = await userEnrollmentController.fetchTopicLessons(widget.topic);

    if (mounted) {
      setState(() {
        lessons = data;
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // calculate percent
    if (widget.topic.numberOfLessons > 0) {
      topicPercent =
          widget.topic.numberOfLessonsDone / widget.topic.numberOfLessons;
    }

    // fetch lessons
    _fetchTopicLessons();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        // progress
        double progressHeight = isTablet
            ? 10.h
            : isSmallTablet
                ? 12.h
                : 14.h;

        return Scaffold(
          backgroundColor: const Color.fromRGBO(104, 180, 255, 1),
          body: SafeArea(
            child: Container(
              color: backgroundColor,
              child: Stack(
                children: [
                  // lessons
                  ListView(
                    children: [
                      // temp container for height
                      Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.all(30.w),
                              color: const Color.fromRGBO(104, 180, 255, 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // back
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      subjectsBack(Colors.white),
                                    ],
                                  ),

                                  // Topic
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  topicTopicName(widget.topic.name),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  topicLessonsNumber(
                                      "${widget.topic.numberOfLessonsDone} of ${widget.topic.numberOfLessons}  lessons",
                                      const Color.fromRGBO(236, 239, 245, 1)),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      // Loading
                      if (loading)
                        loadingContent("Getting Your Lessons",
                            "Be patient while we get your lessons ready for you."),

                      // actual lessons
                      if (!loading && lessons.isEmpty)
                        noDataContent("No Lessons Found",
                            "There were no lessons found for this topic. Please check back later."),

                      ...lessons.map((lesson) {
                        double percent = 0;

                        if (lesson.numberOfSlides > 0) {
                          percent =
                              lesson.numberOfSlidesDone / lesson.numberOfSlides;
                        }

                        return GestureDetector(
                          onTap: () async {
                            if (lesson.active) {
                              await Get.to(() => LoadSlides(
                                    title: "Preparing Your Lesson",
                                    message:
                                        "Get ready to dive in! Your lesson is loading, and we're setting everything up for you.",
                                    type: "lesson",
                                    topic: widget.topic,
                                    lesson: lesson,
                                  ));

                              _fetchTopicLessons();
                            }
                          },
                          child: topicLessonBox(
                            lesson.lessonNumber,
                            lesson.active,
                            lesson.numberOfSlides > 0 &&
                                lesson.numberOfSlides ==
                                    lesson.numberOfSlidesDone,
                            lesson.isFirst,
                            lesson.isLast,
                            lesson.name,
                            "${lesson.numberOfSlidesDone} of ${lesson.numberOfSlides} Slides",
                            percent,
                          ),
                        );
                      }),

                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),

                  // top
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: EdgeInsets.all(30.w),
                                color: const Color.fromRGBO(104, 180, 255, 1),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // back
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: subjectsBack(Colors.white),
                                        ),

                                        // progress
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: const Color.fromRGBO(
                                                  234, 237, 244, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          padding: const EdgeInsets.all(0),
                                          child: LinearPercentIndicator(
                                            width: 200.w,
                                            padding: const EdgeInsets.all(0),
                                            animation: true,
                                            animationDuration: 2000,
                                            lineHeight: progressHeight,
                                            percent: topicPercent,
                                            barRadius: Radius.circular(20.r),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    234, 237, 244, 1),
                                            progressColor: const Color.fromRGBO(
                                                73, 161, 249, 1),
                                          ),
                                        )
                                      ],
                                    ),

                                    // Topic
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    topicTopicName(widget.topic.name),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    topicLessonsNumber(
                                        "${widget.topic.numberOfLessonsDone} of ${widget.topic.numberOfLessons} Lessons",
                                        const Color.fromRGBO(236, 239, 245, 1)),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              )
                            ],
                          ),
                        ),

                        // quiz button
                        Positioned(
                          bottom: 0.h,
                          right: 30.w,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => LoadSlides(
                                    title: "Preparing Your Quiz",
                                    message:
                                        "Get ready to dive in! Your quiz is loading, and we're setting everything up for you.",
                                    type: "topic quiz",
                                    subject: widget.subject,
                                    topic: widget.topic,
                                  ));
                            },
                            child: topicQuizButton(),
                          ),
                        ),
                      ],
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
}
