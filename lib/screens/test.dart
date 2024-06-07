import 'dart:ui';
import 'package:edgiprep/screens/papers.dart';
import 'package:edgiprep/start/start.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
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
  void _openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ChooseSubject(
            type: TestMode.test,
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
                            onTap: _openBottomSheet,
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
                                          "2 hours",
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
                                          "2 hours",
                                          style: GoogleFonts.nunito(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        GestureDetector(
                                          // select paper
                                          onTap: () {},
                                          child: Container(
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
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),

                        // others
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              vertical: 30.w,
                            ),
                            height: 200.h,
                            color: const Color.fromRGBO(0, 47, 99, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Other",
                                  style: GoogleFonts.nunito(
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Check other exams",
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 25.w,
                              ),
                              height: 200.h,
                              color: const Color.fromRGBO(170, 128, 255, 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  Text(
                                    "6 questions",
                                    style: GoogleFonts.nunito(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                      GestureDetector(
                                        // take challenge
                                        onTap: () {},
                                        child: Container(
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // teachers
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: GestureDetector(
                            // take teacher
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 30.w,
                              ),
                              height: 400.h,
                              color: const Color.fromARGB(255, 19, 137, 201),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Teacher Exams",
                                    style: GoogleFonts.nunito(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Practice exams by Teachers",
                                          style: GoogleFonts.nunito(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // teachers
                                  Row(
                                    children: [
                                      Container(
                                        height: 60.h,
                                        width: 60.h,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image:
                                                AssetImage('images/male.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(80.r),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Container(
                                        height: 60.h,
                                        width: 60.h,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image:
                                                AssetImage('images/female.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(80.r),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Container(
                                        height: 60.h,
                                        width: 60.h,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image:
                                                AssetImage('images/male.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(80.r),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
                type == TestMode.test
                    ? "Mock Exam"
                    : type == TestMode.quiz
                        ? "Quiz"
                        : type == TestMode.paper
                            ? "Past Paper"
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
                  itemCount: subjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // image
                          Container(
                            width: 60.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('images/${subjects[index][1]}'),
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
                            "${subjects[index][0]}",
                            style: GoogleFonts.nunito(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 25.h,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
