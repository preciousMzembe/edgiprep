import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/controllers/notification/notification_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_input.dart';
import 'package:edgiprep/views/components/home/daily_challenge_box.dart';
import 'package:edgiprep/views/components/home/exam_switch_content.dart';
import 'package:edgiprep/views/components/home/home_fade_text.dart';
import 'package:edgiprep/views/components/home/home_notification_icon.dart';
import 'package:edgiprep/views/components/home/home_quiz_box.dart';
import 'package:edgiprep/views/components/home/home_section_see_all.dart';
import 'package:edgiprep/views/components/home/home_section_title.dart';
import 'package:edgiprep/views/components/home/home_study_box.dart';
import 'package:edgiprep/views/components/home/home_user_name.dart';
import 'package:edgiprep/views/components/home/home_weekly_box.dart';
import 'package:edgiprep/views/components/home/home_xp_streak_box.dart';
import 'package:edgiprep/views/screens/appraisal/challenges.dart';
import 'package:edgiprep/views/screens/appraisal/quizzes.dart';
import 'package:edgiprep/views/screens/notifications/notifications.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Home extends StatefulWidget {
  final Function toSubjects;
  final Function(UserSubject) toSubject;
  const Home({
    super.key,
    required this.toSubjects,
    required this.toSubject,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ConfigService configService = Get.find<ConfigService>();
  AuthController authController = Get.find<AuthController>();

  UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  NotificationController notificationController =
      Get.find<NotificationController>();

  int quizQuestions = 5;

  Future<void> getConfigValues() async {
    Config? config = await configService.getConfig();

    setState(() {
      quizQuestions = config!.quizQuestions;
    });
  }

  @override
  void initState() {
    getConfigValues();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        // weekly box
        double weeklyTitleSize = isTablet
            ? 22.sp
            : isSmallTablet
                ? 24.sp
                : 26.sp;

        double weeklyProgressRadius = isTablet
            ? 60.sp
            : isSmallTablet
                ? 70.sp
                : 80.sp;

        double weeklyBarWidth = isTablet
            ? 21.r
            : isSmallTablet
                ? 23.r
                : 25.r;

        double weeklyProgressSize = isTablet
            ? 20.sp
            : isSmallTablet
                ? 22.sp
                : 24.sp;

        // xp and streaks
        double xpTitleSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        double xpValueSize = isTablet
            ? 26.sp
            : isSmallTablet
                ? 28.sp
                : 30.sp;

        double xpImageSize = isTablet
            ? 72.h
            : isSmallTablet
                ? 62.h
                : 50.h;

        // study box
        double studyBoxWidth = isTablet
            ? 380.w
            : isSmallTablet
                ? 380.w
                : 380.w;
        double studyImageHeight = isTablet
            ? 100.h
            : isSmallTablet
                ? 90.h
                : 80.h;

        double studySubjectFontSize = isTablet
            ? 16.sp
            : isSmallTablet
                ? 18.sp
                : 20.sp;

        double studyTopicFontSize = isTablet
            ? 20.sp
            : isSmallTablet
                ? 22.sp
                : 24.sp;

        double studyTopicsFontSize = isTablet
            ? 14.sp
            : isSmallTablet
                ? 16.sp
                : 18.sp;

        double studyProgressHeight = isTablet
            ? 10.h
            : isSmallTablet
                ? 12.h
                : 14.h;

        // quiz box
        double quizBoxWidth = isTablet
            ? 420.w
            : isSmallTablet
                ? 420.w
                : 420.w;

        double quizImageContainerHeight = isTablet
            ? 75.r
            : isSmallTablet
                ? 75.r
                : 75.r;

        double quizImageHeight = isTablet
            ? 35.r
            : isSmallTablet
                ? 35.r
                : 35.r;

        double quizSubjectFontSize = isTablet
            ? 24.sp
            : isSmallTablet
                ? 26.sp
                : 28.sp;

        double quizQuestionsFontSize = isTablet
            ? 14.sp
            : isSmallTablet
                ? 16.sp
                : 18.sp;

        return Scaffold(
          backgroundColor: appbarColor,
          body: Obx(() {
            return SafeArea(
              child: Container(
                color: backgroundColor,
                child: LiquidPullToRefresh(
                  onRefresh: () async {
                    await userEnrollmentService.getUserServerExams();
                  },
                  color: primaryColor,
                  backgroundColor: Colors.white,
                  animSpeedFactor: 2,
                  showChildOpacityTransition: false,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      // name and notification
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // name
                                  homeUserName(
                                      "Hey, ${authController.user.value?.name.split(" ")[0] ?? "User"}"),

                                  // welcome
                                  homeFadeText("Keep up the good work"),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // current exam
                                ExamSwitchContent(),

                                SizedBox(
                                  width: 10.w,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const Notifications());
                                    notificationController.openNotifications();
                                  },
                                  child: homeNotificationIcon(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // search
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: const NormalInput(
                          label: "Search Everything",
                          type: TextInputType.text,
                          isPassword: false,
                          icon: FontAwesomeIcons.magnifyingGlass,
                          radius: 16,
                        ),
                      ),

                      // analytics
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              // weekly
                              Expanded(
                                child: homeWeeklyBox(
                                  weeklyTitleSize,
                                  weeklyProgressRadius,
                                  weeklyBarWidth,
                                  weeklyProgressSize,
                                ),
                              ),
                              // xp and streaks
                              SizedBox(
                                width: 30.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: homeXpStreak(
                                        "star.svg",
                                        "Total XPs",
                                        "${authController.user.value?.xp ?? "--"}",
                                        homeLightBackgroundColor,
                                        primaryColor,
                                        xpTitleSize,
                                        xpValueSize,
                                        xpImageSize,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.w,
                                    ),
                                    Expanded(
                                      child: homeXpStreak(
                                        "flame.svg",
                                        "Total Streak",
                                        "${authController.user.value?.streak ?? "--"}",
                                        Colors.white,
                                        homeLightBackgroundColor,
                                        xpTitleSize,
                                        xpValueSize,
                                        xpImageSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // challenge
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const Challenges());
                          },
                          child: dailyChallengeBox(),
                        ),
                      ),

                      // learn
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            homeSectionTitle("Learn"),
                            GestureDetector(
                              onTap: () {
                                widget.toSubjects();
                              },
                              child: homeSectionSeeAll("See all"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      IntrinsicHeight(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // start space
                              SizedBox(
                                width: 30.w,
                              ),

                              // subjects
                              ...userEnrollmentController.subjects
                                  .take(3)
                                  .map((subject) {
                                double percent = 0;

                                if (subject.numberOfTopics > 0) {
                                  percent = subject.numberOfTopicsDone /
                                      subject.numberOfTopics;
                                }
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        widget.toSubject(subject);
                                      },
                                      child: homeStudyBox(
                                        studyBoxWidth,
                                        getFadeColorFromString(subject.color),
                                        subject.image,
                                        studyImageHeight,
                                        studySubjectFontSize,
                                        studyTopicFontSize,
                                        studyTopicsFontSize,
                                        percent,
                                        studyProgressHeight,
                                        subject.title,
                                        subject.description,
                                        "${subject.numberOfTopicsDone} of ${subject.numberOfTopics} Topics",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),

                      // quick quizes
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            homeSectionTitle("Quick Quizzes"),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Quizzes());
                              },
                              child: homeSectionSeeAll("See all"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      IntrinsicHeight(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // start space
                              SizedBox(
                                width: 30.w,
                              ),

                              // subjects
                              ...userEnrollmentController.subjects
                                  .take(3)
                                  .map((subject) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => LoadSlides(
                                              title: "Preparing Your Quiz",
                                              message:
                                                  "Get ready to dive in! Your quiz is loading, and we're setting everything up for you.",
                                              type: "quiz",
                                              subject: subject,
                                            ));
                                      },
                                      child: homeQuizBox(
                                        quizBoxWidth,
                                        subject.icon,
                                        quizImageContainerHeight,
                                        quizImageHeight,
                                        quizSubjectFontSize,
                                        quizQuestionsFontSize,
                                        subject.title,
                                        "$quizQuestions questions | 5 minutes",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
