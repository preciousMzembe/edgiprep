import 'package:edgiprep/screens/start.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TestOption extends StatefulWidget {
  const TestOption({super.key});

  @override
  State<TestOption> createState() => _TestOptionState();
}

class _TestOptionState extends State<TestOption> {
  final ScrollController _controller = ScrollController();
  bool _showBack = true;
  final List<String> _examList = ["JCE", "MSCE", "IGCSE"];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // back
                  SizedBox(
                    width: 75.h,
                    child: MaterialButton(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(75.r),
                      ),
                      height: 75.h,
                      onPressed: () {
                        Get.back();
                      },
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.white,
                          size: 25.h,
                        ),
                      ),
                    ),
                  ),
                  // subject
                  SizedBox(
                    width: 40.w,
                  ),
                  Text(
                    "Mock Test",
                    style: GoogleFonts.nunito(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  final pixels = notification.metrics.pixels;
                  setState(() {
                    _showBack = pixels <= 0; // hide or show to top button
                  });
                  return true;
                },
                child: ListView(
                  controller: _controller,
                  children: [
                    // recommended
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(
                        "Recommended for You",
                        style: GoogleFonts.nunito(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 240.h,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 450.w,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20.w,
                                left: index == 0 ? 30.w : 0.w,
                                top: 10.h,
                                bottom: 10.h,
                              ),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                onPressed: () {
                                  Get.to(() =>
                                      const Start(testMode: TestMode.test));
                                },
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          index == 0
                                              ? "Biology"
                                              : index == 1
                                                  ? "Mathematics"
                                                  : "History",
                                          // textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.nunito(
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "30",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  "questions",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 25.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "2",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  "hours",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 25.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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

                    // others
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(
                        "Choose Other",
                        style: GoogleFonts.nunito(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 100.h,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _examList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 300.w,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20.w,
                                left: index == 0 ? 30.w : 0.w,
                                top: 10.h,
                                bottom: 10.h,
                              ),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.r),
                                ),
                                color: _selectedIndex == index
                                    ? secondaryColor
                                    : Colors.white,
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    _examList[index],
                                    style: GoogleFonts.nunito(
                                      color: _selectedIndex == index
                                          ? Colors.white
                                          : primaryColor,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
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

                    //  exams
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 20.h,
                        children: const [
                          OtherSubject(),
                          OtherSubject(),
                          OtherSubject(),
                        ],
                      ),
                    ),

                    // back to top
                    SizedBox(
                      height: 90.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 10),
                        crossFadeState: _showBack
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Container(),
                        secondChild: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 75.h,
                              child: MaterialButton(
                                color: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(75.r),
                                ),
                                height: 75.h,
                                onPressed: () {
                                  _controller.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.arrowUp,
                                    color: Colors.white,
                                    size: 25.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherSubject extends StatelessWidget {
  const OtherSubject({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.r),
        ),
        onPressed: () {
          Get.to(() => const Start(testMode: TestMode.test));
        },
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Biology",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "30",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "questions",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "2",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "hours",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
