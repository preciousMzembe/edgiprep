import 'dart:async';
import 'dart:ui';

import 'package:edgiprep/controllers/mock/mock_controller.dart';
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

class Mock extends StatefulWidget {
  const Mock({super.key});

  @override
  State<Mock> createState() => _MockState();
}

class _MockState extends State<Mock> {
  MockController mockController = Get.find<MockController>();

  late int _secondsRemaining;
  Timer? _timer;
  bool timeAlmostUp = false;
  bool timeUp = false;

  @override
  void initState() {
    super.initState();

    // start timer
    int minutes = mockController.duration.value;
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
          "Mock",
          "You're about to leave the Mock. Your progress will be saved, and XPs earned will not be lost.",
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
                                "Mock",
                                "You're about to leave the Mock. Your progress will be saved, and XPs earned will not be lost.",
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
                                        width: 300.w,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        animation: true,
                                        animationDuration: 500,
                                        animateFromLastPercent: true,
                                        lineHeight: 14.h,
                                        // Calculate the percent with a check to prevent division errors
                                        percent: mockController
                                                .slides.isNotEmpty
                                            ? (mockController.currentSlideIndex
                                                        .value +
                                                    1) /
                                                mockController.slides.length
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
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                lessonSlidesNumber(
                                    "${mockController.currentSlideIndex.value + 1} / ${mockController.slides.length}"),
                              ],
                            );
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
                          controller: mockController.pageController,
                          onPageChanged: (index) {
                            if (index <
                                mockController.currentSlideIndex.value) {
                              mockController.goToPreviousSlide();
                            } else {
                              mockController.currentSlideIndex.value = index;
                            }
                          },
                          itemCount: mockController.visibleSlides.length,
                          itemBuilder: (context, index) {
                            final slide = mockController.visibleSlides[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: LessonSlide(
                                slide: slide,
                                type: "mock",
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
                          bool isLast = mockController.isLastSlide();

                          if (mockController
                                  .visibleSlides[
                                      mockController.currentSlideIndex.value]
                                  .question ==
                              null) {
                            // not a question
                            mockController.goToNextSlide();
                          } else {
                            // has question
                            // check if answered
                            // if slide not marked done: mark else : go to next
                            if (mockController
                                .visibleSlides[
                                    mockController.currentSlideIndex.value]
                                .slideDone) {
                              // next
                              mockController.goToNextSlide();
                            } else if (mockController
                                    .visibleSlides[
                                        mockController.currentSlideIndex.value]
                                    .question
                                    ?.userAnswerId
                                    .trim() !=
                                "") {
                              // mark
                              mockController.markSlideDone();

                              if (mockController
                                      .visibleSlides[mockController
                                          .currentSlideIndex.value]
                                      .question
                                      ?.correctAnswerId ==
                                  mockController
                                      .visibleSlides[mockController
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
                                mockController.goToNextSlide();
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
                                    child: lessonIncorrect("mock"),
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(0),
                                    ),
                                  ),
                                );
                                mockController.goToNextSlide();
                              }
                            } else {
                              return;
                            }
                          }
                          // finish
                          if (isLast) {
                            Get.to(() => const AppraisalFinish(
                                  type: "mock",
                                ));
                          }
                        },
                        child: Obx(() {
                          return normalButton(
                            mockController
                                        .visibleSlides[mockController
                                            .currentSlideIndex.value]
                                        .question ==
                                    null
                                ? primaryColor
                                : mockController
                                                .visibleSlides[mockController
                                                    .currentSlideIndex.value]
                                                .question !=
                                            null &&
                                        mockController
                                                .visibleSlides[mockController
                                                    .currentSlideIndex.value]
                                                .question
                                                ?.userAnswerId
                                                .trim() !=
                                            ""
                                    ? primaryColor
                                    : const Color.fromRGBO(214, 220, 233, 1),
                            mockController
                                        .visibleSlides[mockController
                                            .currentSlideIndex.value]
                                        .question ==
                                    null
                                ? Colors.white
                                : mockController
                                                .visibleSlides[mockController
                                                    .currentSlideIndex.value]
                                                .question !=
                                            null &&
                                        mockController
                                                .visibleSlides[mockController
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
              if (timeUp) testTimeUp(context, "mock"),
            ],
          ),
        ),
      ),
    );
  }
}
