import 'dart:ui';

import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicNotes extends StatefulWidget {
  const TopicNotes({super.key});

  @override
  State<TopicNotes> createState() => _TopicNotesState();
}

class _TopicNotesState extends State<TopicNotes> {
  final ScrollController _controller = ScrollController();
  bool _scroll = true;

  int _extendIndex = -1;
  void changeExtendIndex(index) {
    setState(() {
      _extendIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // all topics and notes
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // back
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          color: Colors.transparent,
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: primaryColor,
                            size: 40.w,
                          ),
                        ),
                      ),
                      // subject
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Text(
                          "Plant Biology",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                // notes
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        final pixels = notification.metrics.pixels;
                        setState(() {
                          _scroll = pixels <= 0; // hide or show to top button
                        });
                        return true;
                      },
                      child: ListView(
                        controller: _controller,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          LessonNotes(
                            extend: ({index = 0}) {
                              changeExtendIndex(index);
                            },
                            showData: _extendIndex == 0,
                            lessonNumber: 1,
                            lessonName: 'Flowering vs Nonflowering Plants',
                            notes:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin. Nam vitae sapien euismod, molestie velit a, viverra libero. Cras in diam feugiat, efficitur lacus non, vehicula velit. Quisque consectetur magna id purus eleifend, eget aliquet sapien sodales. Integer sed odio ac nulla congue hendrerit. Vivamus placerat enim sed vehicula tempor. Integer quis est sit amet nulla condimentum posuere a vel eros. Phasellus ac venenatis quam, a aliquet quam. Integer ac luctus metus. Nulla facilisi.',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          LessonNotes(
                            extend: ({index = 1}) {
                              changeExtendIndex(index);
                            },
                            showData: _extendIndex == 1,
                            lessonNumber: 2,
                            lessonName: 'Parts of Flowering Plants',
                            notes:
                                'Suspendisse euismod ultricies arcu, at tempor ligula finibus vel. Duis ut lectus leo. Proin fermentum odio et arcu efficitur, vitae scelerisque lectus bibendum. Donec faucibus eleifend erat, ut hendrerit libero rhoncus sed. Aliquam pharetra, odio sed aliquet vehicula, risus ligula sagittis mauris, nec placerat eros lacus sit amet arcu. Sed gravida quam sed urna scelerisque, nec fermentum libero sodales. Nulla facilisi. Suspendisse potenti.\n\n Sed varius, nulla sed accumsan posuere, urna libero accumsan justo, vel lacinia nulla justo ut libero. Donec maximus tortor vel posuere dignissim. Vestibulum bibendum venenatis neque, eu facilisis felis lacinia id.\n\n Maecenas sagittis nulla id dui vestibulum, vel bibendum dolor tempus. Sed lacinia massa eros, vel faucibus eros volutpat a. Vivamus sit amet lorem in est vestibulum luctus ac a dui. Sed at metus lorem. Sed varius purus libero, ac dignissim odio varius ut.',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          LessonNotes(
                            extend: ({index = 2}) {
                              changeExtendIndex(index);
                            },
                            showData: _extendIndex == 2,
                            lessonNumber: 3,
                            lessonName: 'Parts of Nonflowering Plants',
                            notes:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin. Nam vitae sapien euismod, molestie velit a, viverra libero. Cras in diam feugiat, efficitur lacus non, vehicula velit. Quisque consectetur magna id purus eleifend, eget aliquet sapien sodales. Integer sed odio ac nulla congue hendrerit. Vivamus placerat enim sed vehicula tempor. Integer quis est sit amet nulla condimentum posuere a vel eros. Phasellus ac venenatis quam, a aliquet quam. Integer ac luctus metus. Nulla facilisi.',
                          ),

                          // back to top
                          SizedBox(
                            height: 90.h,
                          ),
                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 10),
                            crossFadeState: _scroll
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
                                        duration:
                                            const Duration(milliseconds: 500),
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
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // edit notes
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 60.h,
                ),
                color: const Color.fromARGB(54, 47, 59, 98),
                child: const EditNotes(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Lesson Notes
class LessonNotes extends StatelessWidget {
  final int lessonNumber;
  final String lessonName;
  final String notes;
  final Function extend;
  final bool showData;
  const LessonNotes(
      {super.key,
      required this.lessonNumber,
      required this.lessonName,
      required this.notes,
      required this.extend,
      required this.showData});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // line
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  width: 25.w,
                  height: 25.w,
                  color: primaryColor,
                ),
              ),
              Expanded(
                child: Container(
                  width: 5.w,
                  color: primaryColor,
                ),
              ),
              ClipOval(
                child: Container(
                  width: 25.w,
                  height: 25.w,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20.w,
          ),

          // lesson info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 35.w,
                ),
                // Lesson
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // lesson name
                      child: Text(
                        lessonName,
                        style: GoogleFonts.nunito(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                // notes
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: grayColor,
                      ),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Column(
                      children: [
                        // notes
                        Padding(
                          padding: EdgeInsets.all(30.w),
                          child: Text(
                            showData
                                ? notes
                                : notes.length > 100
                                    ? '${notes.substring(0, 100)}...'
                                    : notes,
                            style: GoogleFonts.nunito(
                              fontSize: 25.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // extend and edit
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // edit
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                    // topRight: Radius.circular(20.r),
                                    topLeft: Radius.circular(40.r),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.pen,
                                    size: 30.w,
                                    color: secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            // extend
                            GestureDetector(
                              onTap: () {
                                if (!showData) {
                                  extend();
                                } else {
                                  extend(index: -1);
                                }
                              },
                              child: Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(40.r),
                                    // topLeft: Radius.circular(20.r),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    showData
                                        ? FontAwesomeIcons.angleUp
                                        : FontAwesomeIcons.angleDown,
                                    size: 30.w,
                                    color: Colors.white,
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
                SizedBox(
                  height: 50.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Edit Notes
class EditNotes extends StatefulWidget {
  const EditNotes({super.key});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 30.h,
      ),
    );
  }
}
