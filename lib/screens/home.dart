import 'package:edgiprep/screens/start.dart';
import 'package:edgiprep/screens/subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
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
            // top
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
                            width: 85.h,
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
                              height: 85.h,
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
                                  fontSize: 25.sp,
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
                                  fontSize: 45.sp,
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
                    height: 85.h,
                    color: primaryColor,
                  ),
                ],
              ),
            ),

            // rewards
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: ClipRRect(
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
                      horizontal: 40.h,
                      vertical: 60.h,
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
                                height: 80.h,
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
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          221, 255, 255, 255),
                                      // height: .9,
                                    ),
                                  ),
                                  Text(
                                    "5030",
                                    style: GoogleFonts.nunito(
                                      fontSize: 50.sp,
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
                                height: 80.h,
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
                                      fontSize: 20.sp,
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
                                          fontSize: 50.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "days",
                                        style: GoogleFonts.nunito(
                                          fontSize: 30.sp,
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
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Practice More",
                    style: GoogleFonts.nunito(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        // quiz
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const Start(
                                  testMode: TestMode.quiz,
                                  lessonDone: false,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(183, 207, 231, 0.5),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    ),
                                    child: Container(
                                      height: 170.h,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/quiz.jpg'),
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
                                        horizontal: 30.w, vertical: 30.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Biology",
                                          style: GoogleFonts.nunito(
                                            fontSize: 35.sp,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "16 ",
                                              style: GoogleFonts.nunito(
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            Text(
                                              "questions",
                                              style: GoogleFonts.nunito(
                                                fontSize: 25.sp,
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
                          width: 30.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const Start(
                                  testMode: TestMode.test,
                                  lessonDone: false,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(139, 160, 251, 0.5),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    ),
                                    child: Container(
                                      height: 170.h,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/test.jpg'),
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
                                        horizontal: 30.w, vertical: 30.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "History",
                                          style: GoogleFonts.nunito(
                                            fontSize: 35.sp,
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
                                                    "16 ",
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "questions",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 25.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "2 ",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Text(
                                                  "hrs",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 25.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black54,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // subjects
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "For You",
                    style: GoogleFonts.nunito(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MSCE Subjects",
                        style: GoogleFonts.nunito(
                          fontSize: 20.sp,
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
                            fontSize: 25.sp,
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
              height: 15.h,
            ),
            SizedBox(
              height: 150.h,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 30.w,
                        left: index == 0 ? 30.w : 0.w,
                        top: 10.h,
                        bottom: 10.h,
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
                                width: 80.h,
                                height: 80.h,
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
                                height: 10.h,
                              ),
                              Text(
                                "${subjects[index][0]}",
                                style: GoogleFonts.nunito(
                                  fontSize: 25.sp,
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
                    width: 10.w,
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
  }
}
