import 'dart:ui';

import 'package:edgiprep/controllers/lesson/lesson_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_close.dart';
import 'package:edgiprep/views/components/lesson/lesson_close_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_correct.dart';
import 'package:edgiprep/views/components/lesson/lesson_incorrect.dart';
import 'package:edgiprep/views/components/lesson/lesson_slide.dart';
import 'package:edgiprep/views/components/lesson/lesson_slides_number.dart';
import 'package:edgiprep/views/screens/subjects/lesson_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonPlayer extends StatefulWidget {
  const LessonPlayer({super.key});

  @override
  State<LessonPlayer> createState() => _LessonPlayerState();
}

class _LessonPlayerState extends State<LessonPlayer> {
  LessonController lessonController = Get.find<LessonController>();

  @override
  void initState() {
    super.initState();

    // Schedule it to run after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        int index = lessonController.currentSlideIndex.value;
        lessonController.pageController
            .animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
            .then((_) {
          lessonController.firstJump.value = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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

      double lessonTitleSize = isTablet
          ? 34.sp
          : isSmallTablet
              ? 36.sp
              : 38.sp;

      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, other) async {
          if (didPop) {
            return;
          }
          showCloseLesson(
            context,
            "Lesson",
            "You're about to leave the lesson. Your progress will be saved, and you can continue from where you left off later.",
          );
        },
        child: Scaffold(
          backgroundColor: appbarColor,
          body: SafeArea(
            child: Container(
              color: backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // indicator
                  Obx(() {
                    return Container(
                      color: lessonController.currentSlideIndex.value == 0
                          ? getFadeColorFromString("rgb(35,131,226)")
                          : Colors.transparent,
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
                                // close
                                GestureDetector(
                                  onTap: () {
                                    showCloseLesson(
                                      context,
                                      "Lesson",
                                      "You're about to leave the lesson. Your progress will be saved, and you can continue from where you left off later.",
                                    );
                                  },
                                  child: lessonCloseButton(),
                                ),

                                // progress
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LinearPercentIndicator(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        width: 300.w,
                                        animation: true,
                                        animationDuration: 500,
                                        animateFromLastPercent: true,
                                        lineHeight: 14.h,
                                        // Calculate the percent with a check to prevent division errors
                                        percent: lessonController
                                                .slides.isNotEmpty
                                            ? (lessonController
                                                        .currentSlideIndex
                                                        .value +
                                                    1) /
                                                lessonController.slides.length
                                            : 0.0, // default to 0 if no slides
                                        barRadius: Radius.circular(20.r),
                                        backgroundColor: Colors.white,
                                        progressColor: const Color.fromRGBO(
                                            73, 161, 249, 1),
                                      ),
                                    ],
                                  ),
                                ),

                                // slides number
                                lessonSlidesNumber(
                                    "${lessonController.currentSlideIndex.value + 1} / ${lessonController.slides.length}",
                                    color: lessonController
                                                .currentSlideIndex.value ==
                                            0
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            161, 168, 183, 1)),
                              ],
                            ),
                          ),
                          if (lessonController.currentSlideIndex.value == 0)
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 30.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Stats
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    lessonController.lessonTitle.value,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: lessonTitleSize,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: statBox(
                                              "alarm-clock.svg",
                                              const Color.fromRGBO(
                                                  73, 161, 249, 1),
                                              "Slides",
                                              statTitleFontSize,
                                              "${lessonController.slides.length}",
                                              statSubtitleFontSize),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Expanded(
                                          child: statBox(
                                              "question-square.svg",
                                              const Color.fromRGBO(
                                                  102, 203, 124, 1),
                                              "Questions",
                                              statTitleFontSize,
                                              "${lessonController.getNumberOfQuestions()}",
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
                                              "${lessonController.getNumberOfQuestions()}",
                                              statSubtitleFontSize),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 30.h,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),

                  SizedBox(
                    height: 6.h,
                  ),

                  // slides
                  Expanded(
                    child: Obx(
                      () => PageView.builder(
                        // scrollDirection: Axis.vertical,
                        physics: const PageScrollPhysics(),
                        controller: lessonController.pageController,
                        onPageChanged: (index) {
                          if (index <
                              lessonController.currentSlideIndex.value) {
                            if (!lessonController.firstJump.value) {
                              lessonController.goToPreviousSlide();
                            }
                          } else {
                            lessonController.currentSlideIndex.value = index;
                          }
                        },
                        itemCount: lessonController.visibleSlides.length,
                        itemBuilder: (context, index) {
                          final slide = lessonController.visibleSlides[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: LessonSlide(
                              slide: slide,
                              type: "lesson",
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // button
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: GestureDetector(
                      onTap: () async {
                        // check if is last slide
                        bool isLast = lessonController.isLastSlide();

                        if (lessonController
                                .visibleSlides[
                                    lessonController.currentSlideIndex.value]
                                .question ==
                            null) {
                          // not a question
                          lessonController.goToNextSlide();
                        } else {
                          // has question
                          // check if answered
                          // if slide not marked done: mark else : go to next
                          if (lessonController
                              .visibleSlides[
                                  lessonController.currentSlideIndex.value]
                              .slideDone) {
                            // next
                            lessonController.goToNextSlide();
                          } else if (lessonController
                                  .visibleSlides[
                                      lessonController.currentSlideIndex.value]
                                  .question
                                  ?.userAnswerId
                                  .trim() !=
                              "") {
                            // mark
                            lessonController.markSlideDone();

                            if (lessonController
                                    .visibleSlides[lessonController
                                        .currentSlideIndex.value]
                                    .question
                                    ?.correctAnswerId ==
                                lessonController
                                    .visibleSlides[lessonController
                                        .currentSlideIndex.value]
                                    .question
                                    ?.userAnswerId) {
                              // correct
                              await showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: false,
                                builder: (BuildContext context) =>
                                    BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: lessonCorrect(lessonController
                                      .visibleSlides[lessonController
                                          .currentSlideIndex.value]
                                      .question!
                                      .explanation),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(0),
                                  ),
                                ),
                              );
                              lessonController.goToNextSlide();
                            } else {
                              // wrong
                              await showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: false,
                                builder: (BuildContext context) =>
                                    BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: lessonIncorrect("lesson"),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(0),
                                  ),
                                ),
                              );
                              lessonController.goToNextSlide();
                            }
                          } else {
                            return;
                          }
                        }
                        // finish
                        if (isLast) {
                          Get.to(() => const LessonFinish());
                        }
                      },
                      child: Obx(() {
                        return normalButton(
                          lessonController
                                      .visibleSlides[lessonController
                                          .currentSlideIndex.value]
                                      .question ==
                                  null
                              ? primaryColor
                              : lessonController
                                              .visibleSlides[lessonController
                                                  .currentSlideIndex.value]
                                              .question !=
                                          null &&
                                      lessonController
                                              .visibleSlides[lessonController
                                                  .currentSlideIndex.value]
                                              .question
                                              ?.userAnswerId
                                              .trim() !=
                                          ""
                                  ? primaryColor
                                  : const Color.fromRGBO(214, 220, 233, 1),
                          lessonController
                                      .visibleSlides[lessonController
                                          .currentSlideIndex.value]
                                      .question ==
                                  null
                              ? Colors.white
                              : lessonController
                                              .visibleSlides[lessonController
                                                  .currentSlideIndex.value]
                                              .question !=
                                          null &&
                                      lessonController
                                              .visibleSlides[lessonController
                                                  .currentSlideIndex.value]
                                              .question
                                              ?.userAnswerId
                                              .trim() !=
                                          ""
                                  ? Colors.white
                                  : Colors.black,
                          "Continue",
                          20,
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
