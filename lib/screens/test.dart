import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
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
                    "Level Up",
                    style: GoogleFonts.nunito(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Take your skill to another level",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
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
                          borderRadius: BorderRadius.circular(20.r),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Text(
                                        //   "Get a combination of questions to put your knowledge to test.",
                                        //   style: GoogleFonts.nunito(
                                        //     // fontSize: 40.sp,
                                        //     // fontWeight: FontWeight.w900,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
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

                        // past papers
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
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
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Text(
                                          //   "Get a combination of questions to put your knowledge to test.",
                                          //   style: GoogleFonts.nunito(
                                          //     // fontSize: 40.sp,
                                          //     // fontWeight: FontWeight.w900,
                                          //     color: Colors.white,
                                          //   ),
                                          // ),
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

                        // others
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
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
                          borderRadius: BorderRadius.circular(20.r),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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

                        // challenge
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
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

                        // teachers
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          image: AssetImage('images/male.jpg'),
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
                                          image: AssetImage('images/male.jpg'),
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
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 80.h,
            ),

            // SizedBox(
            //   height: 240.h,
            //   child: ListView.separated(
            //     physics: const BouncingScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 3,
            //     itemBuilder: (BuildContext context, int index) {
            //       return SizedBox(
            //         width: 450.w,
            //         child: Padding(
            //           padding: EdgeInsets.only(
            //             right: 20.w,
            //             left: index == 0 ? 30.w : 0.w,
            //             top: 10.h,
            //             bottom: 10.h,
            //           ),
            //           child: MaterialButton(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(40.r),
            //             ),
            //             onPressed: () {
            //               Get.to(() => const TestOption());
            //             },
            //             color: Colors.white,
            //             child: Center(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.stretch,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Row(
            //                     children: [
            //                       Icon(
            //                         FontAwesomeIcons.clipboardList,
            //                         size: 45.h,
            //                       ),
            //                     ],
            //                   ),
            //                   SizedBox(
            //                     height: 15.h,
            //                   ),
            //                   Text(
            //                     index == 0
            //                         ? "Mock Test"
            //                         : index == 1
            //                             ? "Past Papers"
            //                             : "Challenge",
            //                     style: GoogleFonts.nunito(
            //                       fontSize: 40.sp,
            //                       fontWeight: FontWeight.w900,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                   // SizedBox(
            //                   //   height: 5.h,
            //                   // ),
            //                   Text(
            //                     "A mock exam, also known.",
            //                     maxLines: 1,
            //                     overflow: TextOverflow.ellipsis,
            //                     style: TextStyle(
            //                       fontSize: 25.sp,
            //                       fontWeight: FontWeight.bold,
            //                       color: textColor,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //     separatorBuilder: (BuildContext context, int index) {
            //       return SizedBox(
            //         width: 10.w,
            //       );
            //     },
            //   ),
            // ),

            // // results
            // SizedBox(
            //   height: 40.h,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30.w),
            //   child: Text(
            //     "Results From Tests",
            //     style: GoogleFonts.nunito(
            //       fontSize: 40.sp,
            //       fontWeight: FontWeight.w900,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            // // results
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30.w),
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 30.h,
            //       ),
            //       const TestResult(
            //         subject: 'Biology Mock',
            //         percent: .6,
            //       ),
            //       SizedBox(
            //         height: 20.h,
            //       ),
            //       const TestResult(
            //         subject: 'Biology 2023',
            //         percent: .5,
            //       ),
            //       SizedBox(
            //         height: 100.h,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class TestResult extends StatelessWidget {
  final String subject;
  final double percent;
  const TestResult({super.key, required this.subject, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 40.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        // border: Border.all(
        //   color: grayColor,
        //   width: 2.w,
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  subject,
                  style: GoogleFonts.nunito(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "${(percent * 100).toStringAsFixed(1)}%",
                style: GoogleFonts.nunito(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 15.h,
            animationDuration: 2000,
            // percent
            percent: percent,
            barRadius: Radius.circular(30.r),
            progressColor: primaryColor,
            backgroundColor: progressColor,
          ),
        ],
      ),
    );
  }
}
