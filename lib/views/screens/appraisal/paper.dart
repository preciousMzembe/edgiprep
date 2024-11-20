import 'dart:ui';

import 'package:edgiprep/controllers/past%20paper/paper_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_close.dart';
import 'package:edgiprep/views/components/lesson/lesson_close_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_correct.dart';
import 'package:edgiprep/views/components/lesson/lesson_incorrect.dart';
import 'package:edgiprep/views/components/lesson/lesson_slide.dart';
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
          "You're about to leave the paper. Your progress will not be saved, but XPs earned will not be lost.",
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
                            "You're about to leave the paper. Your progress will not be saved, but XPs earned will not be lost.",
                          );
                        },
                        child: lessonCloseButton(),
                      ),

                      // progress
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return LinearPercentIndicator(
                                width: 300.w,
                                animation: true,
                                animationDuration: 500,
                                animateFromLastPercent: true,
                                lineHeight: 14.h,
                                // Calculate the percent with a check to prevent division errors
                                percent: paperController.slides.isNotEmpty
                                    ? (paperController.currentSlideIndex.value +
                                            1) /
                                        paperController.slides.length
                                    : 0.0, // default to 0 if no slides
                                barRadius: Radius.circular(20.r),
                                backgroundColor: Colors.white,
                                progressColor:
                                    const Color.fromRGBO(73, 161, 249, 1),
                              );
                            }),
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
                      physics: const NeverScrollableScrollPhysics(),
                      controller: paperController.pageController,
                      onPageChanged: (index) {
                        if (index < paperController.currentSlideIndex.value) {
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
                                ?.userAnswer
                                .trim() !=
                            "") {
                          // mark
                          paperController.markSlideDone();

                          // check if is last slide
                          bool isLast = paperController.isLastSlide();

                          if (paperController
                                  .visibleSlides[
                                      paperController.currentSlideIndex.value]
                                  .question
                                  ?.correctAnswer ==
                              paperController
                                  .visibleSlides[
                                      paperController.currentSlideIndex.value]
                                  .question
                                  ?.userAnswer) {
                            // correct
                            await showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: lessonCorrect(),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                ),
                              ),
                            );
                            paperController.goToNextSlide();

                            // finish
                            if (isLast) {
                              Get.to(() => const AppraisalFinish(
                                    type: "paper",
                                  ));
                            }
                          } else {
                            // wrong
                            await showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: lessonIncorrect("paper"),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                ),
                              ),
                            );
                            paperController.goToNextSlide();

                            // finish
                            if (isLast) {
                              Get.to(() => const AppraisalFinish(
                                    type: "paper",
                                  ));
                            }
                          }
                        }
                      }
                    },
                    child: Obx(() {
                      return normalButton(
                        paperController
                                    .visibleSlides[
                                        paperController.currentSlideIndex.value]
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
                                            ?.userAnswer
                                            .trim() !=
                                        ""
                                ? primaryColor
                                : const Color.fromRGBO(214, 220, 233, 1),
                        paperController
                                    .visibleSlides[
                                        paperController.currentSlideIndex.value]
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
                                            ?.userAnswer
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
  }
}
