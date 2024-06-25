import 'package:edgiprep/controllers/current_mock_controller.dart';
import 'package:edgiprep/mockTabs/answer.dart';
import 'package:edgiprep/models/lesson_question.dart';
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
  CurrentMockController currentmockController =
      Get.find<CurrentMockController>();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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
        List<String> shuffledOptions = currentmockController
            .questions[currentmockController.currentQuestionIndex].options
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
                              currentmockController.title,
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
                                (currentmockController.currentQuestionIndex +
                                        1) /
                                    currentmockController.numberOfQuestions,
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
                                          "${currentmockController.currentQuestionIndex + 1}",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    TextSpan(
                                      text:
                                          "/${currentmockController.numberOfQuestions}",
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
                              ),

                              // timer
                              const Text("02:00:00"),
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
                                i < currentmockController.questions.length;
                                i++)
                              if (currentmockController.currentQuestionIndex >=
                                  i)
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: currentmockController
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
                                            currentmockController.questions[i],
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
                if (currentmockController.selectedIndex >= 0)
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
                          // question status and answer
                          Visibility(
                            visible: currentmockController.checkAnswer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // status
                                Row(
                                  children: [
                                    // icon
                                    if (currentmockController.selectedIndex >=
                                        0)
                                      Container(
                                        width: 50.h,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: shuffledOptions[
                                                      currentmockController
                                                          .selectedIndex] ==
                                                  currentmockController
                                                      .questions[
                                                          currentmockController
                                                              .currentQuestionIndex]
                                                      .answer
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                        ),
                                        child: Icon(
                                          shuffledOptions[currentmockController
                                                      .selectedIndex] ==
                                                  currentmockController
                                                      .questions[
                                                          currentmockController
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
                                    if (currentmockController.selectedIndex >=
                                        0)
                                      Text(
                                        shuffledOptions[currentmockController
                                                    .selectedIndex] ==
                                                currentmockController
                                                    .questions[
                                                        currentmockController
                                                            .currentQuestionIndex]
                                                    .answer
                                            ? "Correct"
                                            : "Wrong",
                                        style: GoogleFonts.nunito(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w900,
                                          color: shuffledOptions[
                                                      currentmockController
                                                          .selectedIndex] ==
                                                  currentmockController
                                                      .questions[
                                                          currentmockController
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
                                if (shuffledOptions[
                                        currentmockController.selectedIndex] !=
                                    currentmockController
                                        .questions[currentmockController
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
                                              currentmockController
                                                  .questions[
                                                      currentmockController
                                                          .currentQuestionIndex]
                                                  .answer,
                                              style: GoogleFonts.nunito(
                                                fontSize: 35.sp,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.green,
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
                              if (!currentmockController.checkAnswer) {
                                // check
                                currentmockController.setCheckAnswer(true);
                              } else {
                                // if last question
                                if (currentmockController.isLastQuestion()) {
                                  // mark
                                  currentmockController.answerSelected(
                                      shuffledOptions[
                                          currentmockController.selectedIndex],
                                      currentmockController
                                          .questions[currentmockController
                                              .currentQuestionIndex]
                                          .answer);

                                  // mark done
                                  currentmockController.setDone(true);

                                  // change page
                                  // if (currentmockController.score !=
                                  //         currentmockController
                                  //             .questions.length) {

                                  //   Get.to(() => const RetryPrompt());
                                  // } else {
                                  //   Get.to(() => const Done());
                                  // }
                                } else {
                                  // next question
                                  currentmockController.answerSelected(
                                      shuffledOptions[
                                          currentmockController.selectedIndex],
                                      currentmockController
                                          .questions[currentmockController
                                              .currentQuestionIndex]
                                          .answer);
                                }

                                _scrollToBottom();
                              }
                            },
                            child: Text(
                              !currentmockController.checkAnswer
                                  ? "Check"
                                  : shuffledOptions[currentmockController
                                              .selectedIndex] !=
                                          currentmockController
                                              .questions[currentmockController
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
                if (currentmockController.done)
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
                                        text: "${currentmockController.score}",
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      TextSpan(
                                        text:
                                            "/${currentmockController.numberOfQuestions}",
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
                                        text: "+90  ",
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
  final LessonQuestion question;
  final int questionIndex;
  const Question(
      {super.key, required this.question, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    CurrentMockController currentmockController =
        Get.find<CurrentMockController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // question
        Text(
          question.question,
          style: GoogleFonts.nunito(
            fontSize: 35.sp,
            fontWeight: FontWeight.w700,
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
                selected: currentmockController.selectedIndex == i &&
                    currentmockController.currentQuestionIndex == questionIndex,
                select: () {
                  if (!currentmockController.checkAnswer &&
                      currentmockController.currentQuestionIndex ==
                          questionIndex &&
                      !currentmockController.done) {
                    currentmockController.setSelectedIndex(i);
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
