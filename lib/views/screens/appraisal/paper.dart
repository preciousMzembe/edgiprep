import 'dart:async';
import 'dart:ui';

import 'package:edgiprep/controllers/past_paper/paper_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/test_time_up.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_close.dart';
import 'package:edgiprep/views/components/lesson/lesson_close_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_correct.dart';
import 'package:edgiprep/views/components/lesson/lesson_incorrect.dart';
import 'package:edgiprep/views/components/lesson/lesson_slide.dart';
import 'package:edgiprep/views/components/lesson/lesson_slides_count_down.dart';
import 'package:edgiprep/views/components/lesson/lesson_slides_number.dart';
import 'package:edgiprep/views/screens/appraisal/appraisal_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  PaperController paperController = Get.find<PaperController>();

  late int _secondsRemaining;
  Timer? _timer;
  bool timeAlmostUp = false;
  bool timeUp = false;

  @override
  void initState() {
    super.initState();

    // start timer
    int minutes = paperController.duration.value;
    if (minutes == 0) {
      minutes = 60;
    }
    _secondsRemaining = minutes * 60;
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();

        setState(() {
          timeUp = true;
        });
      }
    });
  }

  String get formattedTime {
    final hours = _secondsRemaining ~/ 3600;
    final minutes = (_secondsRemaining % 3600) ~/ 60;
    final seconds = _secondsRemaining % 60;

    if (hours == 0 && minutes < 5) {
      setState(() {
        timeAlmostUp = true;
      });
    }

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, other) async {
        if (didPop) {
          return;
        }
        showCloseLesson(
          context,
          "Paper",
          "You're about to leave the Paper. Your progress will be saved, and XPs earned will not be lost.",
        );
      },
      child: Scaffold(
        backgroundColor: appbarColor,
        body: SafeArea(
          child: Stack(
            children: [
              // Body
              Container(
                color: backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // indicator
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
                                "Paper",
                                "You're about to leave the Paper. Your progress will be saved, and XPs earned will not be lost.",
                              );
                            },
                            child: lessonCloseButton(),
                          ),

                          // progress
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // progress bar
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() {
                                      return LinearPercentIndicator(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        width: 300.w,
                                        animation: true,
                                        animationDuration: 500,
                                        animateFromLastPercent: true,
                                        lineHeight: 14.h,
                                        // Calculate the percent with a check to prevent division errors
                                        percent: paperController
                                                .slides.isNotEmpty
                                            ? (paperController.currentSlideIndex
                                                        .value +
                                                    1) /
                                                paperController.slides.length
                                            : 0.0, // default to 0 if no slides
                                        barRadius: Radius.circular(20.r),
                                        backgroundColor: Colors.white,
                                        progressColor: const Color.fromRGBO(
                                            73, 161, 249, 1),
                                      );
                                    }),
                                  ],
                                ),

                                // timer
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  width: 290.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      lessonSlidesCountDown(
                                        formattedTime,
                                        !timeAlmostUp
                                            ? const Color.fromRGBO(
                                                52, 74, 106, 1)
                                            : const Color.fromRGBO(
                                                254, 101, 93, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // slides number
                          Obx(() {
                            return lessonSlidesNumber(
                                "${paperController.currentSlideIndex.value + 1} / ${paperController.slides.length}");
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),

                    // slides
                    Expanded(
                      child: Obx(
                        () => PageView.builder(
                          // scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: paperController.pageController,
                          onPageChanged: (index) {
                            if (index <
                                paperController.currentSlideIndex.value) {
                              paperController.goToPreviousSlide();
                            } else {
                              paperController.currentSlideIndex.value = index;
                            }
                          },
                          itemCount: paperController.visibleSlides.length,
                          itemBuilder: (context, index) {
                            final slide = paperController.visibleSlides[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: LessonSlide(
                                slide: slide,
                                type: "paper",
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
                          bool isLast = paperController.isLastSlide();

                          if (paperController
                                  .visibleSlides[
                                      paperController.currentSlideIndex.value]
                                  .question ==
                              null) {
                            // not a question
                            paperController.goToNextSlide();
                          } else {
                            // has question
                            // check if answered
                            // if slide not marked done: mark else : go to next
                            if (paperController
                                .visibleSlides[
                                    paperController.currentSlideIndex.value]
                                .slideDone) {
                              // next
                              paperController.goToNextSlide();
                            } else if (paperController
                                    .visibleSlides[
                                        paperController.currentSlideIndex.value]
                                    .question
                                    ?.userAnswerId
                                    .trim() !=
                                "") {
                              // mark
                              paperController.markSlideDone();

                              if (paperController
                                      .visibleSlides[paperController
                                          .currentSlideIndex.value]
                                      .question
                                      ?.correctAnswerId ==
                                  paperController
                                      .visibleSlides[paperController
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
                                    child: lessonCorrect(),
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(0),
                                    ),
                                  ),
                                );
                                paperController.goToNextSlide();
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
                                    child: lessonIncorrect("paper"),
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(0),
                                    ),
                                  ),
                                );
                                paperController.goToNextSlide();
                              }
                            } else {
                              return;
                            }
                          }
                          // finish
                          if (isLast) {
                            Get.to(() => const AppraisalFinish(
                                  type: "paper",
                                ));
                          }
                        },
                        child: Obx(() {
                          return normalButton(
                            paperController
                                        .visibleSlides[paperController
                                            .currentSlideIndex.value]
                                        .question ==
                                    null
                                ? primaryColor
                                : paperController
                                                .visibleSlides[paperController
                                                    .currentSlideIndex.value]
                                                .question !=
                                            null &&
                                        paperController
                                                .visibleSlides[paperController
                                                    .currentSlideIndex.value]
                                                .question
                                                ?.userAnswerId
                                                .trim() !=
                                            ""
                                    ? primaryColor
                                    : const Color.fromRGBO(214, 220, 233, 1),
                            paperController
                                        .visibleSlides[paperController
                                            .currentSlideIndex.value]
                                        .question ==
                                    null
                                ? Colors.white
                                : paperController
                                                .visibleSlides[paperController
                                                    .currentSlideIndex.value]
                                                .question !=
                                            null &&
                                        paperController
                                                .visibleSlides[paperController
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

              // Time Up
              if (timeUp) testTimeUp(context, "paper"),
            ],
          ),
        ),
      ),
    );
  }
}
