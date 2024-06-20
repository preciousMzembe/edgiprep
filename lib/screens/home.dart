import 'package:edgiprep/start/start_quiz.dart';
import 'package:edgiprep/screens/subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
import 'package:edgiprep/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final Function seeAll;
  const Home({super.key, required this.seeAll});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constants) {
      final isMobile = Responsive.isMobile(context);
      final isTall = constants.maxHeight > constants.maxWidth;

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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Container(
                                height: isTall ? 80.h : 50.w,
                                width: isTall ? 80.h : 50.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/male.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      85.r,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  height: isTall ? 80.h : 50.w,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello,",
                                    style: TextStyle(
                                      fontSize: isTall ? 25.sp : 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                      height: .9,
                                    ),
                                  ),
                                  Text(
                                    "Precious",
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
                      Image.asset(
                        "icons/bell.png",
                        height: isTall ? 80.h : 40.w,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),

              // rewards
              if (isMobile)
                SizedBox(
                  height: isTall ? 50.h : 25.w,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total XP",
                                      style: TextStyle(
                                        fontSize: isTall ? 20.sp : 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            221, 255, 255, 255),
                                        // height: .9,
                                      ),
                                    ),
                                    Text(
                                      "5030",
                                      style: GoogleFonts.nunito(
                                        fontSize: isTall ? 50.sp : 20.sp,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Streak",
                                      style: TextStyle(
                                        fontSize: isTall ? 20.sp : 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            221, 255, 255, 255),
                                        // height: .9,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "9 ",
                                          style: GoogleFonts.nunito(
                                            fontSize: isTall ? 50.sp : 20.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "days",
                                          style: GoogleFonts.nunito(
                                            fontSize: isTall ? 30.sp : 15.sp,
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
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          // quiz
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const StartQuiz(
                                    subject: "Biology",
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(183, 207, 231, 0.5),
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.r),
                                        topRight: Radius.circular(40.r),
                                      ),
                                      child: Container(
                                        height: isTall ? 170.h : 140.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('images/quiz.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 40.h,
                                            vertical: 60.h,
                                          ),
                                          // color: Color.fromARGB(55, 0, 0, 0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isTall ? 30.w : 15.w,
                                        vertical: isTall ? 30.w : 15.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "Biology",
                                            style: GoogleFonts.nunito(
                                              fontSize: isTall ? 35.sp : 20.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "5 ",
                                                style: GoogleFonts.nunito(
                                                  fontSize:
                                                      isTall ? 30.sp : 15.sp,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              Text(
                                                "questions",
                                                style: GoogleFonts.nunito(
                                                  fontSize:
                                                      isTall ? 25.sp : 13.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black54,
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
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const StartQuiz(
                                    subject: "History",
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(139, 160, 251, 0.5),
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.r),
                                        topRight: Radius.circular(40.r),
                                      ),
                                      child: Container(
                                        height: isTall ? 170.h : 140.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('images/test.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 40.h,
                                            vertical: 60.h,
                                          ),
                                          // color: Color.fromARGB(55, 0, 0, 0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isTall ? 30.w : 15.w,
                                        vertical: isTall ? 30.w : 15.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "History",
                                            style: GoogleFonts.nunito(
                                              fontSize: isTall ? 35.sp : 20.sp,
                                              fontWeight: FontWeight.w900,
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
                                                      "5 ",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: isTall
                                                            ? 30.sp
                                                            : 15.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "questions",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: isTall
                                                              ? 25.sp
                                                              : 13.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       "2 ",
                                              //       style: GoogleFonts.nunito(
                                              //         fontSize: isTall
                                              //             ? 30.sp
                                              //             : 15.sp,
                                              //         fontWeight:
                                              //             FontWeight.w900,
                                              //       ),
                                              //     ),
                                              //     Text(
                                              //       "hrs",
                                              //       style: GoogleFonts.nunito(
                                              //         fontSize: isTall
                                              //             ? 25.sp
                                              //             : 13.sp,
                                              //         fontWeight:
                                              //             FontWeight.w700,
                                              //         color: Colors.black54,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
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
                  itemCount: subjects.length,
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
                            Get.to(() => const Subject());
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // image
                                Container(
                                  width: isTall ? 80.h : 40.w,
                                  height: isTall ? 80.h : 40.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'images/${subjects[index][1]}'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),

                                // name
                                SizedBox(
                                  height: isTall ? 10.h : 5.w,
                                ),
                                Text(
                                  "${subjects[index][0]}",
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

              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ],
      );
    });
  }
}
