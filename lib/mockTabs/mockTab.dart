import 'dart:async';

import 'package:edgiprep/controllers/current_mock_controller.dart';
import 'package:edgiprep/controllers/xp_controller.dart';
import 'package:edgiprep/mockTabs/answer.dart';
import 'package:edgiprep/models/test_question.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MockTab extends StatefulWidget {
  const MockTab({super.key});

  @override
  State<MockTab> createState() => _MockTabState();
}

class _MockTabState extends State<MockTab> {
  CurrentMockController currentMockController =
      Get.find<CurrentMockController>();
  XPController xpQuizController = Get.find<XPController>();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startTimer();
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

  late Duration _remainingTime;
  Timer? _timer;

  void _startTimer() {
    _remainingTime = Duration(
        hours: MockExamTime?['hours'],
        minutes: MockExamTime?['minutes'],
        seconds: MockExamTime?['seconds']);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inMinutes < 2) {
        currentMockController.setTimeAlmostUp(true);
      }

      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        // TODO: End Exam
        currentMockController.setDone(true);
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(() {
        List<String> questionOptions = currentMockController
            .questions[currentMockController.currentQuestionIndex].options
            .toList();
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
                              currentMockController.title,
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
                                (currentMockController.currentQuestionIndex +
                                        1) /
                                    currentMockController.numberOfQuestions,
                            barRadius: Radius.circular(30.r),
                            progressColor: primaryColor,
                            backgroundColor: progressColor,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          // progress numbers
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${currentMockController.currentQuestionIndex + 1}",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    TextSpan(
                                      text:
                                          "/${currentMockController.numberOfQuestions}",
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
                              ),

                              // timer
                              Text(
                                _formatDuration(_remainingTime),
                                style: TextStyle(
                                    color: currentMockController.timeAlmostUp
                                        ? Colors.red
                                        : textColor),
                              ),
                            ],
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
                                i < currentMockController.questions.length;
                                i++)
                              if (currentMockController.currentQuestionIndex >=
                                  i)
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: currentMockController
                                                .currentQuestionIndex ==
                                            i
                                        ? constraints.maxHeight - 100.h
                                        : 60.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Question(
                                        question:
                                            currentMockController.questions[i],
                                        questionIndex: i,
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

                // check and continue
                if (currentMockController.selectedIndex >= 0 &&
                    !currentMockController.done)
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r)),
                    child: Container(
                      color: !currentMockController.checkAnswer
                          ? const Color.fromRGBO(47, 59, 98, 0.178)
                          : questionOptions[
                                      currentMockController.selectedIndex] ==
                                  currentMockController
                                      .questions[currentMockController
                                          .currentQuestionIndex]
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
                            visible: currentMockController.checkAnswer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // status
                                Row(
                                  children: [
                                    // icon
                                    if (currentMockController.selectedIndex >=
                                        0)
                                      Container(
                                        width: 50.h,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: questionOptions[
                                                      currentMockController
                                                          .selectedIndex] ==
                                                  currentMockController
                                                      .questions[
                                                          currentMockController
                                                              .currentQuestionIndex]
                                                      .answer
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                        ),
                                        child: Icon(
                                          questionOptions[currentMockController
                                                      .selectedIndex] ==
                                                  currentMockController
                                                      .questions[
                                                          currentMockController
                                                              .currentQuestionIndex]
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
                                    if (currentMockController.selectedIndex >=
                                        0)
                                      Text(
                                        questionOptions[currentMockController
                                                    .selectedIndex] ==
                                                currentMockController
                                                    .questions[
                                                        currentMockController
                                                            .currentQuestionIndex]
                                                    .answer
                                            ? "Correct"
                                            : "Wrong",
                                        style: GoogleFonts.nunito(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w900,
                                          color: questionOptions[
                                                      currentMockController
                                                          .selectedIndex] ==
                                                  currentMockController
                                                      .questions[
                                                          currentMockController
                                                              .currentQuestionIndex]
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
                                if (questionOptions[
                                        currentMockController.selectedIndex] !=
                                    currentMockController
                                        .questions[currentMockController
                                            .currentQuestionIndex]
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
                                              currentMockController
                                                  .questions[
                                                      currentMockController
                                                          .currentQuestionIndex]
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
                              if (!currentMockController.checkAnswer) {
                                // check
                                currentMockController.setCheckAnswer(true);

                                // mark
                                currentMockController.answerSelected(
                                    questionOptions[
                                        currentMockController.selectedIndex],
                                    currentMockController
                                        .questions[currentMockController
                                            .currentQuestionIndex]
                                        .answer);
                              } else {
                                // if last question
                                if (currentMockController.isLastQuestion()) {
                                  // mark done
                                  currentMockController.setDone(true);
                                } else {
                                  // next question
                                  currentMockController.continueMock();
                                }

                                _scrollToBottom();
                              }
                            },
                            child: Text(
                              !currentMockController.checkAnswer
                                  ? "Check"
                                  : questionOptions[currentMockController
                                              .selectedIndex] !=
                                          currentMockController
                                              .questions[currentMockController
                                                  .currentQuestionIndex]
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
                if (currentMockController.done)
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
                                        text: "${currentMockController.score}",
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      TextSpan(
                                        text:
                                            "/${currentMockController.numberOfQuestions}",
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
                                            "+${currentMockController.score}  ",
                                        style: TextStyle(
                                          color: Colors.green,
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
                              // save XPs
                              xpQuizController
                                  .saveXP(currentMockController.score);
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
  final TestQuestion question;
  final int questionIndex;
  const Question(
      {super.key, required this.question, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    CurrentMockController currentMockController =
        Get.find<CurrentMockController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // question
        Text(
          question.question,
          style: GoogleFonts.nunito(
            fontSize: 30.sp,
            fontWeight: FontWeight.w900,
          ),
        ),

        // answers
        SizedBox(
          height: 50.h,
        ),

        for (int i = 0; i < question.options.length; i++)
          Column(
            children: [
              Answer(
                answer: question.options[i],
                selected: currentMockController.selectedIndex == i &&
                    currentMockController.currentQuestionIndex == questionIndex,
                select: () {
                  if (!currentMockController.checkAnswer &&
                      currentMockController.currentQuestionIndex ==
                          questionIndex &&
                      !currentMockController.done) {
                    currentMockController.setSelectedIndex(i);
                  }
                },
                color: question.options[i] == question.answer &&
                        question.userAnswer != ""
                    ? Colors.green
                    : question.userAnswer == question.options[i] &&
                            question.userAnswer != question.answer &&
                            question.userAnswer != ""
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
