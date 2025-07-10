import 'package:edgiprep/db/lesson/lesson.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/services/lesson/lesson_service.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/general/lesson_test_details_title.dart';
import 'package:edgiprep/views/components/general/loading_content.dart';
import 'package:edgiprep/views/components/general/normal_svg_button.dart';
import 'package:edgiprep/views/components/subjects/subjects_back.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonDetails extends StatefulWidget {
  final UserSubject subject;
  final Topic topic;
  final Lesson lesson;
  const LessonDetails(
      {super.key,
      required this.topic,
      required this.lesson,
      required this.subject});

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  LessonService lessonService = Get.find<LessonService>();

  bool loading = true;
  String author = "";
  List<String> contributors = [];
  int slides = 0;
  int questions = 0;

  @override
  void initState() {
    super.initState();

    getLessonData();
  }

  // get lesson data
  Future<void> getLessonData() async {
    String lessonId = widget.lesson.id;

    if (lessonId != "") {
      var lessonData = await lessonService.fetchLessonData(lessonId);

      if (lessonData['error'] != null && !lessonData['error']) {
        // Process lesson data
        var lessonDetails = lessonData['lessonData'];

        author = lessonDetails['author'] ?? "";
        contributors = List<String>.from(lessonDetails['contributors'] ?? []);
        slides = lessonDetails['slides'] ?? 0;
        questions = lessonDetails['questions'] ?? 0;
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double statTitleFontSize = isTablet
            ? 20.sp
            : isSmallTablet
                ? 22.sp
                : 24.sp;

        double statSubtitleFontSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        double textSize = isTablet
            ? 20.sp
            : isSmallTablet
                ? 22.sp
                : 24.sp;

        double authorHeight = isTablet
            ? 66.sp
            : isSmallTablet
                ? 68.sp
                : 60.h;

        return Scaffold(
          backgroundColor: getBackgroundColorFromString(widget.subject.color),
          body: SafeArea(
            child: Container(
              color: backgroundColor,
              child: Stack(
                children: [
                  // Body
                  ListView(
                    children: [
                      // Top Copy
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 30.h,
                        ),
                        color:
                            getBackgroundColorFromString(widget.subject.color),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: subjectsBack(Colors.white),
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                // Name
                                Center(
                                  child: lessonTestDetailsTitle(
                                    widget.lesson.name,
                                    Colors.white,
                                  ),
                                ),

                                // Subject
                                SizedBox(
                                  height: 8.h,
                                ),
                                Center(
                                  child: appraisalTestSubtitle(
                                      widget.topic.name,
                                      const Color.fromRGBO(236, 239, 245, 1)),
                                ),
                              ],
                            ),

                            // Stats
                            SizedBox(
                              height: 30.h,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: statBox(
                                        "slides.svg",
                                        const Color.fromRGBO(102, 203, 124, 1),
                                        "Slides",
                                        statTitleFontSize,
                                        "$slides",
                                        statSubtitleFontSize),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Expanded(
                                    child: statBox(
                                        "question-square.svg",
                                        const Color.fromRGBO(73, 161, 249, 1),
                                        "Questions",
                                        statTitleFontSize,
                                        "$questions",
                                        statSubtitleFontSize),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Expanded(
                                    child: statBox(
                                        "star2.svg",
                                        const Color.fromRGBO(249, 220, 105, 1),
                                        "Total XPs",
                                        statTitleFontSize,
                                        "10",
                                        statSubtitleFontSize),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 50.h,
                            ),
                          ],
                        ),
                      ),

                      // Main Body
                      SizedBox(
                        height: 70.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Loading
                            if (loading)
                              loadingContent("Getting Test Details",
                                  "Be patient while we get test details for you."),

                            // Author and Contributors
                            if (!loading && author.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "This lesson was developed with care by our dedicated author, with additional contributions from others who helped shape its content. We thank everyone who played a part in bringing it to life.",
                                    style: GoogleFonts.inter(
                                      fontSize: textSize,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          const Color.fromRGBO(92, 101, 120, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  if (author.isNotEmpty ||
                                      contributors.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: appraisalHeading(
                                          "Author & Contributors"),
                                    ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  if (author.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        contributorBox(
                                          author,
                                          "Author",
                                          authorHeight,
                                          textSize,
                                          getBackgroundColorFromString(
                                              widget.subject.color),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    ),
                                  if (contributors.isNotEmpty)
                                    ...contributors.map((contributor) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          contributorBox(
                                            contributor,
                                            "Contributor",
                                            authorHeight,
                                            textSize,
                                            getBackgroundColorFromString(
                                                widget.subject.color),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                        ],
                                      );
                                    }),
                                ],
                              ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),

                  // Top
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 30.h,
                              ),
                              color: getBackgroundColorFromString(
                                  widget.subject.color),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: subjectsBack(Colors.white),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      // Name
                                      Center(
                                        child: lessonTestDetailsTitle(
                                          widget.lesson.name,
                                          Colors.white,
                                        ),
                                      ),

                                      // Subject
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Center(
                                        child: appraisalTestSubtitle(
                                            widget.topic.name,
                                            const Color.fromRGBO(
                                                236, 239, 245, 1)),
                                      ),
                                    ],
                                  ),

                                  // Stats
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: statBox(
                                              "slides.svg",
                                              const Color.fromRGBO(
                                                  102, 203, 124, 1),
                                              "Slides",
                                              statTitleFontSize,
                                              "$slides",
                                              statSubtitleFontSize),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Expanded(
                                          child: statBox(
                                              "question-square.svg",
                                              const Color.fromRGBO(
                                                  73, 161, 249, 1),
                                              "Questions",
                                              statTitleFontSize,
                                              "$questions",
                                              statSubtitleFontSize),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Expanded(
                                          child: statBox(
                                              "star2.svg",
                                              const Color.fromRGBO(
                                                  249, 220, 105, 1),
                                              "Total XPs",
                                              statTitleFontSize,
                                              "$questions",
                                              statSubtitleFontSize),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 50.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),

                        // Play
                        if (!loading)
                          Positioned(
                            bottom: 0.h,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(80.r),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await Get.to(
                                          () => LoadSlides(
                                            title: "Preparing Your Lesson",
                                            message:
                                                "Get ready to dive in! Your lesson is loading, and we're setting everything up for you.",
                                            type: "lesson",
                                            topic: widget.topic,
                                            lesson: widget.lesson,
                                          ),
                                        );

                                        Get.back();
                                      },
                                      child: Container(
                                        color: getColorFromString(
                                            widget.subject.color),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 100.w),
                                        child: normalSvgButton(
                                            getColorFromString(
                                                widget.subject.color),
                                            Colors.white,
                                            "Start Lesson",
                                            0,
                                            "play.svg"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

Widget statBox(String icon, Color iconColor, String title, double titleFont,
    String subtitle, double subFont) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 30.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'icons/$icon',
            height: 40.h,
            width: 40.h,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          SizedBox(
            height: 18.h,
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color.fromRGBO(17, 25, 37, 1),
              fontSize: titleFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: subFont,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(161, 168, 183, 1),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget contributorBox(String name, String role, double indicatorHeight,
    double textSize, Color color) {
  return Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: Container(
          height: indicatorHeight,
          width: indicatorHeight,
          color: color,
          child: Center(
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : "",
              style: GoogleFonts.inter(
                fontSize: textSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      SizedBox(
        width: 20.w,
      ),

      // Name and Role
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: textSize,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(17, 25, 37, 1),
            ),
          ),
          Text(
            role,
            style: GoogleFonts.inter(
              fontSize: textSize - 2,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(92, 101, 120, 1),
            ),
          ),
        ],
      ),
    ],
  );
}
