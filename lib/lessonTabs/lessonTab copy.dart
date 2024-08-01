// import 'package:edgiprep/controllers/current_lesson_controller.dart';
// import 'package:edgiprep/lessonTabs/answer.dart';
// import 'package:edgiprep/models/lesson_question.dart';
// import 'package:edgiprep/utils/constants.dart';
// import 'package:edgiprep/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// class LessonTab extends StatefulWidget {
//   const LessonTab({super.key});

//   @override
//   State<LessonTab> createState() => _LessonTabState();
// }

// class _LessonTabState extends State<LessonTab> {
//   CurrentLessonController currentLessonController =
//       Get.find<CurrentLessonController>();

//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(seconds: 1),
//         curve: Curves.easeOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Obx(() {
//         List<String> shuffledOptions = currentLessonController
//             .questions[currentLessonController.currentQuestionIndex].options
//             .toList();
//         return Scaffold(
//           backgroundColor: backgroundColor,
//           body: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(
//                   height: 30.h,
//                 ),
//                 // top
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // close
//                           IconButton(
//                             onPressed: () {
//                               // show popup before closing

//                               showCloseQuizDialog(
//                                 context,
//                                 "Quit Lesson?",
//                                 "Are you sure you want to quit lesson?",
//                                 () {
//                                   Get.back();
//                                   Get.back();
//                                   Get.back();
//                                 },
//                               );
//                             },
//                             icon: Icon(
//                               FontAwesomeIcons.xmark,
//                               size: 40.h,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20.w,
//                           ),
//                           Expanded(
//                             child: Text(
//                               currentLessonController.title,
//                               maxLines: 1,
//                               textAlign: TextAlign.center,
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.nunito(
//                                 fontSize: 35.sp,
//                                 fontWeight: FontWeight.w900,
//                               ),
//                             ),
//                           ),
//                           // SizedBox(
//                           //   width: 20.w,
//                           // ),
//                           // // report question
//                           // IconButton(
//                           //   onPressed: () {},
//                           //   icon: Icon(
//                           //     FontAwesomeIcons.solidFlag,
//                           //     size: 30.h,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       // progress
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           LinearPercentIndicator(
//                             padding: const EdgeInsets.all(0),
//                             // animation: true,
//                             lineHeight: 15.h,
//                             // animationDuration: 2000,
//                             // percent
//                             percent:
//                                 (currentLessonController.currentQuestionIndex +
//                                         1) /
//                                     currentLessonController.numberOfQuestions,
//                             barRadius: Radius.circular(30.r),
//                             progressColor: primaryColor,
//                             backgroundColor: progressColor,
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           // progress numbers
//                           // RichText(
//                           //   text: TextSpan(
//                           //     style: GoogleFonts.nunito(
//                           //       color: Colors.black,
//                           //       fontSize: 25.sp,
//                           //       fontWeight: FontWeight.w900,
//                           //     ),
//                           //     children: [
//                           //       TextSpan(
//                           //         text:
//                           //             "${currentLessonController.currentQuestionIndex + 1}",
//                           //         style: TextStyle(color: primaryColor),
//                           //       ),
//                           //       TextSpan(
//                           //         text:
//                           //             "/${currentLessonController.numberOfQuestions}",
//                           //         style: TextStyle(color: textColor),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // question and answers
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Expanded(
//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 30.w),
//                         child: ListView(
//                           controller: _scrollController,
//                           children: [
//                             SizedBox(
//                               height: 30.h,
//                             ),
//                             // questions

//                             for (int i = 0;
//                                 i < currentLessonController.questions.length;
//                                 i++)
//                               if (currentLessonController
//                                       .currentQuestionIndex >=
//                                   i)
//                                 ConstrainedBox(
//                                   constraints: BoxConstraints(
//                                     minHeight: currentLessonController
//                                                 .currentQuestionIndex ==
//                                             i
//                                         ? constraints.maxHeight - 100.h
//                                         : 60.h,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Question(
//                                         question: currentLessonController
//                                             .questions[i],
//                                         questionIndex: i,
//                                       ),
//                                       SizedBox(
//                                         height: 60.h,
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                             // bottom
//                             SizedBox(
//                               height: 100.h,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 // Continue to question button
//                 if (!currentLessonController.showQuestion &&
//                     !currentLessonController.done)
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(40.r),
//                         topRight: Radius.circular(40.r)),
//                     child: Container(
//                       color: const Color.fromRGBO(47, 59, 98, 0.178),
//                       padding: EdgeInsets.symmetric(
//                         vertical: 40.h,
//                         horizontal: 30.h,
//                       ),
//                       child: MaterialButton(
//                         color: secondaryColor,
//                         height: 100.h,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(100.r),
//                         ),
//                         onPressed: () {
//                           // go to question
//                           currentLessonController.goToQuestion();
//                         },
//                         child: Text(
//                           "Continue",
//                           style: GoogleFonts.nunito(
//                             color: primaryColor,
//                             fontSize: 40.sp,
//                             fontWeight: FontWeight.w900,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                 // check and continue
//                 if (currentLessonController.selectedIndex >= 0 &&
//                     currentLessonController.showQuestion)
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(40.r),
//                         topRight: Radius.circular(40.r)),
//                     child: Container(
//                       color: !currentLessonController.checkAnswer
//                           ? const Color.fromRGBO(47, 59, 98, 0.178)
//                           : shuffledOptions[
//                                       currentLessonController.selectedIndex] ==
//                                   currentLessonController
//                                       .questions[currentLessonController
//                                           .currentQuestionIndex]
//                                       .answer
//                               ? const Color.fromRGBO(76, 175, 79, 0.178)
//                               : const Color.fromRGBO(244, 67, 54, 0.178),
//                       padding: EdgeInsets.symmetric(
//                         vertical: 40.h,
//                         horizontal: 30.h,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           // question status and answer
//                           Visibility(
//                             visible: currentLessonController.checkAnswer,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 // status
//                                 Row(
//                                   children: [
//                                     // icon
//                                     if (currentLessonController.selectedIndex >=
//                                         0)
//                                       Container(
//                                         width: 50.h,
//                                         height: 50.h,
//                                         decoration: BoxDecoration(
//                                           color: shuffledOptions[
//                                                       currentLessonController
//                                                           .selectedIndex] ==
//                                                   currentLessonController
//                                                       .questions[
//                                                           currentLessonController
//                                                               .currentQuestionIndex]
//                                                       .answer
//                                               ? Colors.green
//                                               : Colors.red,
//                                           borderRadius:
//                                               BorderRadius.circular(50.r),
//                                         ),
//                                         child: Icon(
//                                           shuffledOptions[
//                                                       currentLessonController
//                                                           .selectedIndex] ==
//                                                   currentLessonController
//                                                       .questions[
//                                                           currentLessonController
//                                                               .currentQuestionIndex]
//                                                       .answer
//                                               ? FontAwesomeIcons.check
//                                               : FontAwesomeIcons.xmark,
//                                           size: 25.h,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     SizedBox(
//                                       width: 15.w,
//                                     ),
//                                     // correct or wrong
//                                     if (currentLessonController.selectedIndex >=
//                                         0)
//                                       Text(
//                                         shuffledOptions[currentLessonController
//                                                     .selectedIndex] ==
//                                                 currentLessonController
//                                                     .questions[
//                                                         currentLessonController
//                                                             .currentQuestionIndex]
//                                                     .answer
//                                             ? "Correct"
//                                             : "Wrong",
//                                         style: GoogleFonts.nunito(
//                                           fontSize: 40.sp,
//                                           fontWeight: FontWeight.w900,
//                                           color: shuffledOptions[
//                                                       currentLessonController
//                                                           .selectedIndex] ==
//                                                   currentLessonController
//                                                       .questions[
//                                                           currentLessonController
//                                                               .currentQuestionIndex]
//                                                       .answer
//                                               ? Colors.green
//                                               : Colors.red,
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 20.h,
//                                 ),
//                                 // answer
//                                 if (shuffledOptions[currentLessonController
//                                         .selectedIndex] !=
//                                     currentLessonController
//                                         .questions[currentLessonController
//                                             .currentQuestionIndex]
//                                         .answer)
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Answer: ",
//                                             style: GoogleFonts.nunito(
//                                               fontSize: 25.sp,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               currentLessonController
//                                                   .questions[
//                                                       currentLessonController
//                                                           .currentQuestionIndex]
//                                                   .answer,
//                                               style: GoogleFonts.nunito(
//                                                 fontSize: 25.sp,
//                                                 fontWeight: FontWeight.w900,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 20.h,
//                                       ),
//                                     ],
//                                   ),
//                               ],
//                             ),
//                           ),
//                           // check
//                           MaterialButton(
//                             color: secondaryColor,
//                             height: 100.h,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100.r),
//                             ),
//                             onPressed: () {
//                               if (!currentLessonController.checkAnswer) {
//                                 // check
//                                 currentLessonController.setCheckAnswer(true);
//                               } else {
//                                 // if last question
//                                 if (currentLessonController.isLastQuestion()) {
//                                   // mark
//                                   currentLessonController.answerSelected(
//                                       shuffledOptions[currentLessonController
//                                           .selectedIndex],
//                                       currentLessonController
//                                           .questions[currentLessonController
//                                               .currentQuestionIndex]
//                                           .answer);

//                                   // mark done
//                                   currentLessonController.setDone(true);

//                                   // change page
//                                   // if (currentLessonController.score !=
//                                   //         currentLessonController
//                                   //             .questions.length) {

//                                   //   Get.to(() => const RetryPrompt());
//                                   // } else {
//                                   //   Get.to(() => const Done());
//                                   // }
//                                 } else {
//                                   // next question
//                                   currentLessonController.answerSelected(
//                                       shuffledOptions[currentLessonController
//                                           .selectedIndex],
//                                       currentLessonController
//                                           .questions[currentLessonController
//                                               .currentQuestionIndex]
//                                           .answer);
//                                 }

//                                 _scrollToBottom();
//                               }
//                             },
//                             child: Text(
//                               !currentLessonController.checkAnswer
//                                   ? "Check"
//                                   : shuffledOptions[currentLessonController
//                                               .selectedIndex] !=
//                                           currentLessonController
//                                               .questions[currentLessonController
//                                                   .currentQuestionIndex]
//                                               .answer
//                                       ? "Got It"
//                                       : "Continue",
//                               style: GoogleFonts.nunito(
//                                 color: primaryColor,
//                                 fontSize: 40.sp,
//                                 fontWeight: FontWeight.w900,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                 // finish
//                 if (currentLessonController.done)
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(40.r),
//                         topRight: Radius.circular(40.r)),
//                     child: Container(
//                       color: const Color.fromRGBO(47, 59, 98, 0.178),
//                       padding: EdgeInsets.symmetric(
//                         vertical: 40.h,
//                         horizontal: 30.h,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           // progress numbers
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 RichText(
//                                   text: TextSpan(
//                                     style: GoogleFonts.nunito(
//                                       color: Colors.black,
//                                       fontSize: 35.sp,
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text:
//                                             "${currentLessonController.score}",
//                                         style: TextStyle(color: primaryColor),
//                                       ),
//                                       TextSpan(
//                                         text:
//                                             "/${currentLessonController.numberOfQuestions}",
//                                         style: TextStyle(color: textColor),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 RichText(
//                                   textAlign: TextAlign.center,
//                                   text: TextSpan(
//                                     style: GoogleFonts.nunito(
//                                       color: Colors.black,
//                                       fontSize: 35.sp,
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text: "+90  ",
//                                         style: TextStyle(
//                                           color: Colors.green,
//                                           fontSize: 35.sp,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: "XPs",
//                                         style: GoogleFonts.nunito(
//                                           fontSize: 30.sp,
//                                           fontWeight: FontWeight.w900,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30.h,
//                           ),

//                           // finish button
//                           MaterialButton(
//                             color: secondaryColor,
//                             height: 100.h,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100.r),
//                             ),
//                             onPressed: () {
//                               Get.back();
//                               Get.back();
//                             },
//                             child: Text(
//                               "Finish",
//                               style: GoogleFonts.nunito(
//                                 color: primaryColor,
//                                 fontSize: 40.sp,
//                                 fontWeight: FontWeight.w900,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// class Question extends StatelessWidget {
//   final LessonQuestion question;
//   final int questionIndex;
//   const Question(
//       {super.key, required this.question, required this.questionIndex});

//   @override
//   Widget build(BuildContext context) {
//     CurrentLessonController currentLessonController =
//         Get.find<CurrentLessonController>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // lesson content
//         Text(
//           question.lessonContent,
//           style: GoogleFonts.nunito(
//             fontSize: 30.sp,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         // question and anwers
//         SizedBox(
//           height: 50.h,
//         ),
//         AnimatedOpacity(
//           opacity:
//               (currentLessonController.currentQuestionIndex == questionIndex &&
//                           currentLessonController.showQuestion) ||
//                       currentLessonController.currentQuestionIndex !=
//                           questionIndex ||
//                       currentLessonController.done
//                   ? 1.0
//                   : 0.0,
//           duration: const Duration(seconds: 1),
//           child: (currentLessonController.currentQuestionIndex ==
//                           questionIndex &&
//                       currentLessonController.showQuestion) ||
//                   currentLessonController.currentQuestionIndex !=
//                       questionIndex ||
//                   currentLessonController.done
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       question.question,
//                       style: GoogleFonts.nunito(
//                         fontSize: 30.sp,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),

//                     // answers
//                     SizedBox(
//                       height: 50.h,
//                     ),

//                     for (int i = 0; i < question.options.length; i++)
//                       Column(
//                         children: [
//                           Answer(
//                             answer: question.options[i],
//                             selected: currentLessonController.selectedIndex ==
//                                     i &&
//                                 currentLessonController.currentQuestionIndex ==
//                                     questionIndex,
//                             select: () {
//                               if (!currentLessonController.checkAnswer &&
//                                   currentLessonController
//                                           .currentQuestionIndex ==
//                                       questionIndex &&
//                                   !currentLessonController.done) {
//                                 currentLessonController.setSelectedIndex(i);
//                               }
//                             },
//                             color: question.options[i] == question.answer &&
//                                     question.userAnswer != ""
//                                 ? Colors.green
//                                 : question.userAnswer == question.options[i] &&
//                                         question.userAnswer !=
//                                             question.answer &&
//                                         question.userAnswer != ""
//                                     ? Colors.red
//                                     : Colors.transparent,
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                         ],
//                       ),
//                   ],
//                 )
//               : Container(),
//         ),
//       ],
//     );
//   }
// }
