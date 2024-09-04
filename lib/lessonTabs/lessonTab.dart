import 'package:edgiprep/controllers/current_lesson_controller.dart';
import 'package:edgiprep/mockTabs/answer.dart';
import 'package:edgiprep/models/lesson_slide.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LessonTab extends StatefulWidget {
  const LessonTab({super.key});

  @override
  State<LessonTab> createState() => _LessonTabState();
}

class _LessonTabState extends State<LessonTab> {
  CurrentLessonController currentLessonController =
      Get.find<CurrentLessonController>();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(() {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // top
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // close
                          IconButton(
                            onPressed: () {
                              showCloseQuizDialog(
                                context,
                                "Quit Exam",
                                "Are you sure you want to quit the exam?",
                                () {
                                  Get.back();
                                  Get.back();
                                  Get.back();
                                },
                              );
                            },
                            icon: Icon(
                              FontAwesomeIcons.xmark,
                              size: 40.h,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: Text(
                              currentLessonController.title,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 20.w,
                          // ),
                          // // report question
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     FontAwesomeIcons.solidFlag,
                          //     size: 30.h,
                          //   ),
                          // ),
                        ],
                      ),
                      // progress
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            // animation: true,
                            lineHeight: 15.h,
                            // animationDuration: 2000,
                            // percent
                            percent:
                                (currentLessonController.currentSlideIndex +
                                        1) /
                                    currentLessonController.numberOfSlides,
                            barRadius: Radius.circular(30.r),
                            progressColor: primaryColor,
                            backgroundColor: progressColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // question and answers
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: ListView(
                          controller: _scrollController,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            // questions

                            for (int i = 0;
                                i < currentLessonController.slides.length;
                                i++)
                              if (currentLessonController.currentSlideIndex >=
                                  i)
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: currentLessonController
                                                .currentSlideIndex ==
                                            i
                                        ? constraints.maxHeight - 100.h
                                        : 60.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Content or Question
                                      if (currentLessonController
                                              .slides[i].question !=
                                          null)
                                        Question(
                                          question: currentLessonController
                                              .slides[i].question,
                                          questionIndex: i,
                                        ),
                                      if (currentLessonController
                                              .slides[i].content !=
                                          null)
                                        Text(
                                          currentLessonController
                                                  .slides[i].content ??
                                              "",
                                          style: GoogleFonts.nunito(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      SizedBox(
                                        height: 60.h,
                                      ),
                                    ],
                                  ),
                                ),

                            // bottom
                            SizedBox(
                              height: 100.h,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Continue to question button
                if (currentLessonController
                            .slides[currentLessonController.currentSlideIndex]
                            .content !=
                        null &&
                    !currentLessonController.done)
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r)),
                    child: Container(
                      color: const Color.fromRGBO(47, 59, 98, 0.178),
                      padding: EdgeInsets.symmetric(
                        vertical: 40.h,
                        horizontal: 30.h,
                      ),
                      child: MaterialButton(
                        color: secondaryColor,
                        height: 100.h,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        onPressed: () {
                          // save and go to question
                          if (!currentLessonController.isLastSlide()) {
                            // save content progress
                            currentLessonController.saveProgress(
                                false,
                                currentLessonController
                                    .slides[currentLessonController
                                        .currentSlideIndex]
                                    .lessonId
                                    .toString(),
                                "");

                            // next
                            currentLessonController.goToNextSlide();
                          } else {
                            // mark done
                            currentLessonController.setDone(true);
                          }
                        },
                        child: Text(
                          "Continue",
                          style: GoogleFonts.nunito(
                            color: primaryColor,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),

                // check and continue
                if (currentLessonController.selectedIndex >= 0)
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r)),
                    child: Container(
                      color: !currentLessonController.checkAnswer
                          ? const Color.fromRGBO(47, 59, 98, 0.178)
                          : currentLessonController
                                          .slides[currentLessonController
                                              .currentSlideIndex]
                                          .question!
                                          .options[
                                      currentLessonController.selectedIndex] ==
                                  currentLessonController
                                      .slides[currentLessonController
                                          .currentSlideIndex]
                                      .question!
                                      .answer
                              ? const Color.fromRGBO(76, 175, 79, 0.178)
                              : const Color.fromRGBO(244, 67, 54, 0.178),
                      padding: EdgeInsets.symmetric(
                        vertical: 40.h,
                        horizontal: 30.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // question status and answer
                          Visibility(
                            visible: currentLessonController.checkAnswer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // status
                                Row(
                                  children: [
                                    // icon
                                    if (currentLessonController.selectedIndex >=
                                        0)
                                      Container(
                                        width: 50.h,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: currentLessonController
                                                          .slides[currentLessonController
                                                              .currentSlideIndex]
                                                          .question!
                                                          .options[
                                                      currentLessonController
                                                          .selectedIndex] ==
                                                  currentLessonController
                                                      .slides[
                                                          currentLessonController
                                                              .currentSlideIndex]
                                                      .question!
                                                      .answer
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                        ),
                                        child: Icon(
                                          currentLessonController
                                                          .slides[currentLessonController
                                                              .currentSlideIndex]
                                                          .question!
                                                          .options[
                                                      currentLessonController
                                                          .selectedIndex] ==
                                                  currentLessonController
                                                      .slides[
                                                          currentLessonController
                                                              .currentSlideIndex]
                                                      .question!
                                                      .answer
                                              ? FontAwesomeIcons.check
                                              : FontAwesomeIcons.xmark,
                                          size: 25.h,
                                          color: Colors.white,
                                        ),
                                      ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    // correct or wrong
                                    if (currentLessonController.selectedIndex >=
                                        0)
                                      Text(
                                        currentLessonController
                                                        .slides[
                                                            currentLessonController
                                                                .currentSlideIndex]
                                                        .question!
                                                        .options[
                                                    currentLessonController
                                                        .selectedIndex] ==
                                                currentLessonController
                                                    .slides[
                                                        currentLessonController
                                                            .currentSlideIndex]
                                                    .question!
                                                    .answer
                                            ? "Correct"
                                            : "Wrong",
                                        style: GoogleFonts.nunito(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w900,
                                          color: currentLessonController
                                                          .slides[currentLessonController
                                                              .currentSlideIndex]
                                                          .question!
                                                          .options[
                                                      currentLessonController
                                                          .selectedIndex] ==
                                                  currentLessonController
                                                      .slides[
                                                          currentLessonController
                                                              .currentSlideIndex]
                                                      .question!
                                                      .answer
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                // answer
                                if (currentLessonController
                                            .slides[currentLessonController
                                                .currentSlideIndex]
                                            .question!
                                            .options[
                                        currentLessonController
                                            .selectedIndex] !=
                                    currentLessonController
                                        .slides[currentLessonController
                                            .currentSlideIndex]
                                        .question!
                                        .answer)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Answer: ",
                                            style: GoogleFonts.nunito(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              currentLessonController
                                                  .slides[
                                                      currentLessonController
                                                          .currentSlideIndex]
                                                  .question!
                                                  .answer,
                                              style: GoogleFonts.nunito(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          // check
                          MaterialButton(
                            color: secondaryColor,
                            height: 100.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            onPressed: () {
                              if (!currentLessonController.checkAnswer) {
                                // check and save progress
                                currentLessonController.setCheckAnswer(true);

                                // save question progress
                                currentLessonController.saveProgress(
                                  true,
                                  currentLessonController
                                      .slides[currentLessonController
                                          .currentSlideIndex]
                                      .lessonId
                                      .toString(),
                                  currentLessonController
                                          .slides[currentLessonController
                                              .currentSlideIndex]
                                          .question!
                                          .options[
                                      currentLessonController.selectedIndex],
                                );
                              } else {
                                // if last question
                                if (currentLessonController.isLastSlide()) {
                                  // mark
                                  currentLessonController.answerSelected(
                                      currentLessonController
                                              .slides[currentLessonController
                                                  .currentSlideIndex]
                                              .question!
                                              .options[
                                          currentLessonController
                                              .selectedIndex],
                                      currentLessonController
                                          .slides[currentLessonController
                                              .currentSlideIndex]
                                          .question!
                                          .answer);

                                  // mark done
                                  currentLessonController.setDone(true);
                                } else {
                                  // mark and next question
                                  currentLessonController.answerSelected(
                                      currentLessonController
                                              .slides[currentLessonController
                                                  .currentSlideIndex]
                                              .question!
                                              .options[
                                          currentLessonController
                                              .selectedIndex],
                                      currentLessonController
                                          .slides[currentLessonController
                                              .currentSlideIndex]
                                          .question!
                                          .answer);
                                }

                                _scrollToBottom();
                              }
                            },
                            child: Text(
                              !currentLessonController.checkAnswer
                                  ? "Check"
                                  : currentLessonController
                                                  .slides[
                                                      currentLessonController
                                                          .currentSlideIndex]
                                                  .question!
                                                  .options[
                                              currentLessonController
                                                  .selectedIndex] !=
                                          currentLessonController
                                              .slides[currentLessonController
                                                  .currentSlideIndex]
                                              .question!
                                              .answer
                                      ? "Got It"
                                      : "Continue",
                              style: GoogleFonts.nunito(
                                color: primaryColor,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // finish
                if (currentLessonController.done)
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r)),
                    child: Container(
                      color: const Color.fromRGBO(47, 59, 98, 0.178),
                      padding: EdgeInsets.symmetric(
                        vertical: 40.h,
                        horizontal: 30.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // progress numbers
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.nunito(
                                      color: Colors.black,
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${currentLessonController.score}",
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      TextSpan(
                                        text:
                                            "/${currentLessonController.getNumberOfQuestions()}",
                                        style: TextStyle(color: textColor),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: GoogleFonts.nunito(
                                      color: Colors.black,
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "+${currentLessonController.score}  ",
                                        style: TextStyle(
                                          color:
                                              currentLessonController.score != 0
                                                  ? Colors.green
                                                  : Colors.red,
                                          fontSize: 35.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "XPs",
                                        style: GoogleFonts.nunito(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),

                          // finish button
                          MaterialButton(
                            color: secondaryColor,
                            height: 100.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            onPressed: () {
                              Get.back();
                              Get.back();
                            },
                            child: Text(
                              "Finish",
                              style: GoogleFonts.nunito(
                                color: primaryColor,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Question extends StatelessWidget {
  final LessonQuestion? question;
  final int questionIndex;
  const Question(
      {super.key, required this.question, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    CurrentLessonController currentLessonController =
        Get.find<CurrentLessonController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // question
        Text(
          question!.question,
          style: GoogleFonts.nunito(
            fontSize: 30.sp,
            fontWeight: FontWeight.w900,
          ),
        ),

        // answers
        SizedBox(
          height: 50.h,
        ),

        for (int i = 0; i < question!.options.length; i++)
          Column(
            children: [
              Answer(
                answer: question!.options[i],
                selected: currentLessonController.selectedIndex == i &&
                    currentLessonController.currentSlideIndex == questionIndex,
                select: () {
                  if (!currentLessonController.checkAnswer &&
                      currentLessonController.currentSlideIndex ==
                          questionIndex &&
                      !currentLessonController.done &&
                      question?.userAnswer == "") {
                    currentLessonController.setSelectedIndex(i);
                  }
                },
                color: question?.options[i] == question?.answer &&
                        question?.userAnswer != ""
                    ? Colors.green
                    : question?.userAnswer == question?.options[i] &&
                            question?.userAnswer != question?.answer &&
                            question?.userAnswer != ""
                        ? Colors.red
                        : Colors.transparent,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
      ],
    );
  }
}
