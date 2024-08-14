import 'package:edgiprep/controllers/add_exam_controller.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/screens/add_exam.dart';
import 'package:edgiprep/start/start_quiz.dart';
import 'package:edgiprep/screens/subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/responsive.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final Function seeAll;
  const Home({super.key, required this.seeAll});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AddExamController addExamController = Get.find<AddExamController>();
  UserController userController = Get.find<UserController>();
  final bool showData = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constants) {
      final isMobile = Responsive.isMobile(context);
      final isTall = constants.maxHeight > constants.maxWidth;

      return Obx(() {
        // get 2 random subjects
        List randomSubjects =
            getRandomSubjects(userController.currentSubjects, 2);

        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: isTall ? 30.h : 50.h,
                ),
                // top
                if (isMobile)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // name
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(100.r),
                              //   child: Container(
                              //     height: isTall ? 80.h : 50.w,
                              //     width: isTall ? 80.h : 50.w,
                              //     decoration: const BoxDecoration(
                              //       image: DecorationImage(
                              //         image: AssetImage('images/male.jpg'),
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 20.w,
                              // ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello,",
                                      style: TextStyle(
                                        fontSize: isTall ? 25.sp : 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                        height: .9,
                                      ),
                                    ),
                                    Text(
                                      userController.userName.value,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.nunito(
                                        fontSize: isTall ? 45.sp : 25.sp,
                                        fontWeight: FontWeight.w900,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // notifications
                        SizedBox(
                          width: 30.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            showTopModalBottomSheet(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  userController.currentExam['examName'] ?? "",
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  FontAwesomeIcons.angleDown,
                                  size: 18,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        // Icon(
                        //   FontAwesomeIcons.solidBell,
                        //   size: isTall ? 40.h : 30.w,
                        //   color: primaryColor,
                        // ),
                      ],
                    ),
                  ),

                // welcome
                if (!showData)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "images/learn.png",
                              width: 180,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // const Text("Get Sarted"),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          "We're glad to \nhave you here. ",
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.seeAll();
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Text(
                                      "Start Lessons",
                                      style: TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.arrowRight,
                                      size: 15,
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                // xps, practice, subjects
                if (showData)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // rewards
                      if (isMobile)
                        SizedBox(
                          height: isTall ? 35.h : 25.w,
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTall ? 30.w : 50.h,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/questions.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40.h,
                                vertical: isTall ? 60.h : 30.w,
                              ),
                              color: const Color.fromARGB(169, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // XP
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "icons/star.png",
                                          height: isTall ? 80.h : 40.w,
                                          color: secondaryColor,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total XP",
                                              style: TextStyle(
                                                fontSize:
                                                    isTall ? 20.sp : 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    221, 255, 255, 255),
                                                // height: .9,
                                              ),
                                            ),
                                            Text(
                                              userController.xps.value,
                                              style: GoogleFonts.nunito(
                                                fontSize:
                                                    isTall ? 50.sp : 20.sp,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Streak
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "icons/fire.png",
                                          height: isTall ? 80.h : 40.w,
                                          color: secondaryColor,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Streak",
                                              style: TextStyle(
                                                fontSize:
                                                    isTall ? 20.sp : 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    221, 255, 255, 255),
                                                // height: .9,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  userController.streak.value,
                                                  style: GoogleFonts.nunito(
                                                    fontSize:
                                                        isTall ? 50.sp : 20.sp,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  " days",
                                                  style: GoogleFonts.nunito(
                                                    fontSize:
                                                        isTall ? 30.sp : 15.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromARGB(
                                                        204, 255, 255, 255),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // practice
                      SizedBox(
                        height: isTall ? 50.h : 25.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTall ? 30.w : 50.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Take Three Minutes to Practice",
                              style: GoogleFonts.nunito(
                                fontSize: isTall ? 30.sp : 15.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: isTall ? 25.h : 15.w),
                            if (!randomSubjects.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Container(
                                  height: 200.h,
                                  color: const Color.fromARGB(15, 0, 0, 0),
                                ),
                              ),
                            if (randomSubjects.isNotEmpty)
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    // quiz
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => StartQuiz(
                                              subject: randomSubjects[0],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                183, 207, 231, 0.5),
                                            borderRadius:
                                                BorderRadius.circular(40.r),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(40.r),
                                                  topRight:
                                                      Radius.circular(40.r),
                                                ),
                                                child: Container(
                                                  height:
                                                      isTall ? 170.h : 140.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/quiz.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40.h,
                                                      vertical: 60.h,
                                                    ),
                                                    // color: Color.fromARGB(55, 0, 0, 0),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      isTall ? 30.w : 15.w,
                                                  vertical:
                                                      isTall ? 30.w : 15.w,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      randomSubjects[0]
                                                          ['subjectName'],
                                                      style: GoogleFonts.nunito(
                                                        fontSize: isTall
                                                            ? 35.sp
                                                            : 20.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "$QuizQuestionNumber ",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: isTall
                                                                ? 30.sp
                                                                : 15.sp,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                        Text(
                                                          "questions",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: isTall
                                                                ? 25.sp
                                                                : 13.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // test
                                    SizedBox(
                                      width: isTall ? 30.w : 50.h,
                                    ),
                                    Expanded(
                                      child: randomSubjects.length != 1
                                          ? GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => StartQuiz(
                                                    subject: randomSubjects[1],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      139, 160, 251, 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.r),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                40.r),
                                                        topRight:
                                                            Radius.circular(
                                                                40.r),
                                                      ),
                                                      child: Container(
                                                        height: isTall
                                                            ? 170.h
                                                            : 140.w,
                                                        decoration:
                                                            const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'images/test.jpg'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.h,
                                                            vertical: 60.h,
                                                          ),
                                                          // color: Color.fromARGB(55, 0, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: isTall
                                                            ? 30.w
                                                            : 15.w,
                                                        vertical: isTall
                                                            ? 30.w
                                                            : 15.w,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Text(
                                                            randomSubjects[1]
                                                                ['subjectName'],
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: isTall
                                                                  ? 35.sp
                                                                  : 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "$QuizQuestionNumber ",
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        fontSize: isTall
                                                                            ? 30.sp
                                                                            : 15.sp,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        "questions",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          fontSize: isTall
                                                                              ? 25.sp
                                                                              : 13.sp,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const Text(""),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      // subjects
                      SizedBox(
                        height: isTall ? 50.h : 25.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTall ? 30.w : 50.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "For You",
                              style: GoogleFonts.nunito(
                                fontSize: isTall ? 30.sp : 15.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue from where you stopped",
                                  style: GoogleFonts.nunito(
                                    fontSize: isTall ? 20.sp : 10.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.seeAll();
                                  },
                                  child: Text(
                                    "See all",
                                    style: GoogleFonts.nunito(
                                      fontSize: isTall ? 25.sp : 13.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: isTall ? 15.h : 15.w,
                      ),
                      SizedBox(
                        height: isTall ? 180.h : 85.w,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: userController.currentSubjects.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0
                                      ? isTall
                                          ? 30.w
                                          : 50.h
                                      : 0.w,
                                  top: isTall ? 10.h : 5.w,
                                  bottom: isTall ? 10.h : 5.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => Subject(
                                          subject: userController
                                              .currentSubjects[index],
                                        ));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // image
                                        Container(
                                          width: isTall ? 80.h : 40.w,
                                          height: isTall ? 80.h : 40.w,
                                          color: Colors.transparent,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            child: Image.network(
                                              "${userController.currentSubjects[index]['subjectImage']}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        // name
                                        SizedBox(
                                          height: isTall ? 10.h : 5.w,
                                        ),
                                        Text(
                                          "${userController.currentSubjects[index]['subjectName']}",
                                          style: GoogleFonts.nunito(
                                            fontSize: isTall ? 25.sp : 15.sp,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: isTall ? 30.w : 50.h,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ],
        );
      });
    });
  }

  void showTopModalBottomSheet(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      // transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: double.infinity,
                color: Colors.white,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),

                    // Exams
                    ...userController.userExams.map(
                      (exam) => Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ExamSwitch(
                            name: exam['examName'],
                            color: exam['examId'] != null &&
                                    userController.currentExam['examId'] ==
                                        exam['examId']
                                ? secondaryColor
                                : const Color.fromRGBO(158, 158, 158, 0.6),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),

                    // const ExamSwitch(
                    //   name: "JCE",
                    //   color: Color.fromRGBO(158, 158, 158, 0.6),
                    // ),
                    // Add Exam
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        addExamController.resetController();
                        Get.to(() => const AddExam());
                      },
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(158, 158, 158, 0.4),
                          ),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: Color.fromRGBO(158, 158, 158, 0.4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

class ExamSwitch extends StatelessWidget {
  final String name;
  final Color color;
  const ExamSwitch({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: 2,
          color: color,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ),
    );
  }
}
