import 'package:edgiprep/db/mock_exam/mock_exam.dart';
import 'package:edgiprep/db/past_paper/past_paper.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/services/mock/mock_service.dart';
import 'package:edgiprep/services/paper/paper_service.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_title.dart';
import 'package:edgiprep/views/components/general/loading_content.dart';
import 'package:edgiprep/views/components/general/no_data_content.dart';
import 'package:edgiprep/views/components/general/normal_svg_button.dart';
import 'package:edgiprep/views/components/subjects/subjects_back.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TestDetails extends StatefulWidget {
  final UserSubject subject;
  final PastPaper? pastPaper;
  final MockExam? mockExam;
  const TestDetails(
      {super.key, required this.subject, this.pastPaper, this.mockExam});

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  MockService mockService = Get.find<MockService>();
  PaperService paperService = Get.find<PaperService>();

  bool loading = true;

  String testId = "";
  String testType = "";
  int duration = 0;

  String testName = "";
  String subject = "";
  int questions = 0;

  List<dynamic> testHistory = [];

  @override
  void initState() {
    super.initState();

    getTestData();
  }

  // get test data
  Future<void> getTestData() async {
    testId = widget.pastPaper?.id ?? widget.mockExam?.id ?? "";

    if (testId != "") {
      var testData = {};

      if (widget.pastPaper != null) {
        testType = "paper";
        subject = "${widget.subject.title} Past Paper";
        testData = await paperService.fetchData(testId);
      } else if (widget.mockExam != null) {
        testType = "mock";
        subject = "${widget.subject.title} Mock Exam";
        testData = await mockService.fetchData(testId);
      }

      if (testData['error'] != null && !testData['error']) {
        var paperInfo =
            testType == "paper" ? testData['paperData'] : testData['mockData'];

        var historyRecords = paperInfo['testDones'] ?? [];

        for (var record in historyRecords) {
          if (record['isDone'] != null && record['isDone']) {
            testHistory.add({
              "score": record['score'] != null ? "${record['score']}" : "0",
              "date": record['createdAt'] ?? "Unknown",
            });
          }
        }

        duration = paperInfo['duration'] ?? 0;
        testName = paperInfo['name'] ?? "Test Name";
        questions = paperInfo['testInstances']?.length ?? 0;
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

                            if (testName.isNotEmpty && subject.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  // Name
                                  Center(
                                    child: appraisalTestTitle(
                                      testName,
                                      Colors.white,
                                    ),
                                  ),

                                  // Subject
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Center(
                                    child: appraisalTestSubtitle(subject,
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
                                        "question-square.svg",
                                        const Color.fromRGBO(102, 203, 124, 1),
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
                                        "alarm-clock.svg",
                                        const Color.fromRGBO(73, 161, 249, 1),
                                        "Duration",
                                        statTitleFontSize,
                                        "$duration minutes",
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

                            // No Info
                            if (!loading && testHistory.isEmpty)
                              noDataContent("No History Available",
                                  "Get started by taking a test. Your test history will appear here."),

                            // History
                            if (!loading && testHistory.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: appraisalHeading("Test History"),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  ...testHistory.map(
                                    (history) {
                                      double score = double.parse(
                                          history['score'] ?? "0.0");
                                      String date =
                                          history['date'] ?? "Unknown Date";

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          testHistoryBox(score, date),
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
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
                                  if (testName.isNotEmpty && subject.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        // Name
                                        Center(
                                          child: appraisalTestTitle(
                                            testName,
                                            Colors.white,
                                          ),
                                        ),

                                        // Subject
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Center(
                                          child: appraisalTestSubtitle(
                                              subject,
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
                                              "question-square.svg",
                                              const Color.fromRGBO(
                                                  102, 203, 124, 1),
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
                                              "alarm-clock.svg",
                                              const Color.fromRGBO(
                                                  73, 161, 249, 1),
                                              "Duration",
                                              statTitleFontSize,
                                              "$duration minutes",
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
                                      onTap: () {
                                        Get.back();

                                        Get.to(
                                          () => LoadSlides(
                                            title:
                                                "Preparing Your ${testType == "paper" ? "Past Paper" : "Mock Exam"}",
                                            message:
                                                "Get ready to dive in! Your test is loading, and we're setting everything up for you.",
                                            type: testType,
                                            testId: testId,
                                            duration: duration,
                                          ),
                                        );
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
                                            "Start Test",
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

Widget testHistoryBox(
  double score,
  String date,
) {
  String getDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String formatted = DateFormat('EEEE, d MMMM').format(date);
    return formatted;
  }

  Color scoreColor = score >= 75
      ? const Color.fromRGBO(102, 203, 124, 1)
      : score >= 50
          ? const Color.fromRGBO(73, 161, 249, 1)
          : const Color.fromRGBO(254, 101, 93, 1);

  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      // details

      double scoreHeight = isTablet
          ? 100.h
          : isSmallTablet
              ? 90.h
              : 80.h;

      double nameSize = isTablet
          ? 28.sp
          : isSmallTablet
              ? 30.sp
              : 32.sp;

      double textSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // score
              SizedBox(
                width: scoreHeight,
                height: scoreHeight,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 16.r,
                  backgroundColor: scoreColor.withAlpha(30),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    scoreColor,
                  ),
                ),
              ),

              // details
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // name
                    Text(
                      "${score.toStringAsFixed(0)}% Questions Passed",
                      style: GoogleFonts.inter(
                        fontSize: nameSize,
                        fontWeight: FontWeight.w800,
                        color: const Color.fromRGBO(52, 74, 106, 1),
                      ),
                    ),

                    // text
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Played on ${getDate(date)}",
                      style: GoogleFonts.inter(
                        fontSize: textSize,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(161, 168, 183, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
