import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/subject/subject_progress.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/loading_content.dart';
import 'package:edgiprep/views/components/home/home_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave_loading_indicator/wave_progress.dart';

class SubjectProgressPane extends StatefulWidget {
  final UserSubject subject;
  const SubjectProgressPane({
    super.key,
    required this.subject,
  });

  @override
  State<SubjectProgressPane> createState() => _SubjectProgressPaneState();
}

class _SubjectProgressPaneState extends State<SubjectProgressPane> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  late SubjectProgress subjectProgress;
  bool loading = true;

  Future<void> getProgress() async {
    var progress = await userEnrollmentController
        .getSubjectProgress(widget.subject.enrollmentId);

    setState(() {
      subjectProgress = progress;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getProgress();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double pieHeight = isTablet
            ? 220.r
            : isSmallTablet
                ? 230.r
                : 240.r;

        double titleFontSize = isTablet
            ? 20.sp
            : isSmallTablet
                ? 22.sp
                : 24.sp;

        double subtitleFontSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 18.sp
                : 20.sp;

        double statTitleFontSize = isTablet
            ? 36.sp
            : isSmallTablet
                ? 38.sp
                : 40.sp;

        double statSubtitleFontSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        return Container(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // Loading
                if (loading)
                  loadingContent("Getting Your Progress",
                      "Be patient while we get your ${widget.subject.title} progress."),
                if (!loading)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: homeSectionTitle("Subject Statistics"),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // progress
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: Text(
                                  "Subject Progress",
                                  style: GoogleFonts.inter(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: const Color.fromRGBO(244, 246, 249, 1),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50.w,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // chart
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(pieHeight),
                                          child: Container(
                                            height: pieHeight,
                                            width: pieHeight,
                                            color: const Color.fromRGBO(
                                                248, 248, 250, 1),
                                          ),
                                        ),
                                        // pie
                                        WaveProgress(
                                          borderSize: 0,
                                          size: pieHeight,
                                          borderColor: Colors.transparent,
                                          foregroundWaveColor:
                                              getColorFromString(
                                                  widget.subject.color),
                                          backgroundWaveColor:
                                              getFadeColorFromString(
                                                  widget.subject.color),
                                          progress: subjectProgress
                                                      .totalLessons >
                                                  0
                                              ? double.parse((subjectProgress
                                                          .completedLessons /
                                                      subjectProgress
                                                          .totalLessons *
                                                      100)
                                                  .toStringAsFixed(2))
                                              : 0,
                                          innerPadding: 0,
                                        ),

                                        // info
                                        SizedBox(
                                          height: pieHeight,
                                          width: pieHeight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${subjectProgress.totalLessons > 0 ? (subjectProgress.completedLessons / subjectProgress.totalLessons * 100).round() : 0}%",
                                                style: GoogleFonts.inter(
                                                  fontSize: statTitleFontSize,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "Subject Progress",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  fontSize:
                                                      statSubtitleFontSize,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromARGB(
                                                      255, 55, 55, 70),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    // calculations
                                    SizedBox(
                                      width: 40.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // lessons
                                          Text(
                                            "${subjectProgress.completedLessons} / ${subjectProgress.totalLessons}",
                                            style: GoogleFonts.inter(
                                              fontSize: titleFontSize,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "Completed Lessons",
                                            style: GoogleFonts.inter(
                                              fontSize: subtitleFontSize,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromRGBO(
                                                  161, 168, 183, 1),
                                            ),
                                          ),

                                          // topics
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            "${subjectProgress.coveredTopics} (${subjectProgress.totalTopics > 0 ? (subjectProgress.coveredTopics / subjectProgress.totalTopics * 100).round() : 0}%)",
                                            style: GoogleFonts.inter(
                                              fontSize: titleFontSize,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "Covered Topics",
                                            style: GoogleFonts.inter(
                                              fontSize: subtitleFontSize,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromRGBO(
                                                  161, 168, 183, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // statistics
                      SizedBox(
                        height: 30.h,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: statBox(
                                  "${subjectProgress.completedQuizzes}",
                                  statTitleFontSize,
                                  "Completed Quizzes",
                                  statSubtitleFontSize),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Expanded(
                              child: statBox(
                                  "${subjectProgress.completedMocks}",
                                  statTitleFontSize,
                                  "Completed Mock Exams",
                                  statSubtitleFontSize),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Expanded(
                              child: statBox(
                                  "${subjectProgress.completedPPs}",
                                  statTitleFontSize,
                                  "Completed Past Papers",
                                  statSubtitleFontSize),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                SizedBox(
                  height: 100.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget statBox(
    String title, double titleFont, String subtitle, double subFont) {
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
          Text(
            title,
            style: GoogleFonts.inter(
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
