import 'package:cached_network_image/cached_network_image.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/screens/papers.dart';
import 'package:edgiprep/start/start_challenge.dart';
import 'package:edgiprep/start/start_mock.dart';
import 'package:edgiprep/start/start_quiz.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  void _openBottomSheet(TestMode testmode) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ChooseSubject(
            type: testmode,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    // "Level Up",
                    "Take your skill to another level",
                    style: GoogleFonts.nunito(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  // Text(
                  //   "Take your skill to another level",
                  //   style: TextStyle(
                  //     fontSize: 25.sp,
                  //     fontWeight: FontWeight.bold,
                  //     color: textColor,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),

            // exams list
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // mock and past papers
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // mock
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: GestureDetector(
                            onTap: () {
                              _openBottomSheet(TestMode.mock);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/questions.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 30.w,
                                ),
                                height: 400.h,
                                color: const Color.fromARGB(166, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Mock Exam",
                                      style: GoogleFonts.nunito(
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Take a mock test and see how prepared you are.",
                                            style: GoogleFonts.nunito(
                                              // fontSize: 40.sp,
                                              // fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // time and play
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          MockExamTime?['hours'] != 0 &&
                                                  MockExamTime?['hours'] != null
                                              ? "${MockExamTime?['hours']} ${MockExamTime?['hours'] > 1 ? "hours" : "hour"}"
                                              : MockExamTime?['minutes'] != 0
                                                  ? "${MockExamTime?['minutes']} minutes"
                                                  : "${MockExamTime?['seconds']} seconds",
                                          style: GoogleFonts.nunito(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          height: 60.h,
                                          width: 60.h,
                                          decoration: BoxDecoration(
                                            color: progressColor,
                                            borderRadius:
                                                BorderRadius.circular(80.r),
                                            border: Border.all(
                                              width: 2.0,
                                              color: const Color.fromRGBO(
                                                  170, 128, 255, 1),
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              FontAwesomeIcons.play,
                                              size: 25.h,
                                              color: const Color.fromRGBO(
                                                  170, 128, 255, 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // past papers
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: GestureDetector(
                            onTap: () {
                              _openBottomSheet(TestMode.paper);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/past.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.w,
                                    vertical: 30.w,
                                  ),
                                  height: 400.h,
                                  color: const Color.fromARGB(166, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Past Papers",
                                        style: GoogleFonts.nunito(
                                          fontSize: 35.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Take a look at Past Papers to help you prepare.",
                                              style: GoogleFonts.nunito(
                                                // fontSize: 40.sp,
                                                // fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // time and play
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: GoogleFonts.nunito(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 60.h,
                                            width: 60.h,
                                            decoration: BoxDecoration(
                                              color: progressColor,
                                              borderRadius:
                                                  BorderRadius.circular(80.r),
                                              border: Border.all(
                                                width: 2.0,
                                                color: const Color.fromRGBO(
                                                    27, 174, 252, 1),
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                FontAwesomeIcons.play,
                                                size: 25.h,
                                                color: const Color.fromRGBO(
                                                    27, 174, 252, 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // quiz, challenge and teachers
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // quiz
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: GestureDetector(
                            onTap: () {
                              _openBottomSheet(TestMode.quiz);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/challenge.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 25.w,
                                ),
                                height: 400.h,
                                color: const Color.fromARGB(166, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Quiz",
                                      style: GoogleFonts.nunito(
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Take a quick quiz",
                                            style: GoogleFonts.nunito(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // time and play
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$QuizQuestionNumber questions",
                                          style: GoogleFonts.nunito(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          height: 60.h,
                                          width: 60.h,
                                          decoration: BoxDecoration(
                                            color: progressColor,
                                            borderRadius:
                                                BorderRadius.circular(80.r),
                                            border: Border.all(
                                              width: 2.0,
                                              color: const Color.fromARGB(
                                                  255, 56, 132, 224),
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              FontAwesomeIcons.play,
                                              size: 25.h,
                                              color: const Color.fromARGB(
                                                  255, 56, 132, 224),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // challenge
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: GestureDetector(
                            onTap: () {
                              _openBottomSheet(TestMode.challenge);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/challenge_2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 30.w,
                                ),
                                height: 400.h,
                                color: const Color.fromARGB(166, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Challenge",
                                      style: GoogleFonts.nunito(
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Challenge your knowledge with unlimited pool of questions.",
                                            style: GoogleFonts.nunito(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // time and play
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Nonstop",
                                          style: GoogleFonts.nunito(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          height: 60.h,
                                          width: 60.h,
                                          decoration: BoxDecoration(
                                            color: progressColor,
                                            borderRadius:
                                                BorderRadius.circular(80.r),
                                            border: Border.all(
                                              width: 2.0,
                                              color: const Color.fromRGBO(
                                                  255, 25, 45, 1),
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              FontAwesomeIcons.play,
                                              size: 25.h,
                                              color: const Color.fromRGBO(
                                                  255, 25, 45, 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ],
    );
  }
}

// choose exam subject
class ChooseSubject extends StatelessWidget {
  final TestMode type;
  const ChooseSubject({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return Obx(() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 30.h,
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  type == TestMode.mock
                      ? "Mock Exam"
                      : type == TestMode.quiz
                          ? "Quiz"
                          : type == TestMode.paper
                              ? "Past Papers"
                              : type == TestMode.challenge
                                  ? "Challenge"
                                  : type == TestMode.teacher
                                      ? "Teacher Exams"
                                      : "Other",
                  style: GoogleFonts.nunito(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: userController.currentSubjects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            type == TestMode.mock
                                ? Get.to(
                                    () => StartMock(
                                      subject:
                                          userController.currentSubjects[index],
                                    ),
                                  )
                                : type == TestMode.quiz
                                    ? Get.to(
                                        () => StartQuiz(
                                          subject: userController
                                              .currentSubjects[index],
                                        ),
                                      )
                                    : type == TestMode.paper
                                        ? Get.to(
                                            () => Papers(
                                              subject: userController
                                                  .currentSubjects[index],
                                            ),
                                          )
                                        : type == TestMode.challenge
                                            ? Get.to(
                                                () => StartChallenge(
                                                  subject: userController
                                                      .currentSubjects[index],
                                                ),
                                              )
                                            : type == TestMode.teacher
                                                ? ()
                                                : () {};
                          },
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.h,
                            vertical: 20.h,
                          ),
                          // color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // image
                              Container(
                                width: 60.h,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "${userController.currentSubjects[index]["subjectImage"]}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),

                              // name
                              SizedBox(
                                width: 25.w,
                              ),
                              Text(
                                "${userController.currentSubjects[index]["subjectName"]}",
                                style: GoogleFonts.nunito(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 0.h,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
