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
  bool _showDetails = true;
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Plant Biology",
                          style: GoogleFonts.nunito(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        // SizedBox(
                        //   height: 5.h,
                        // ),
                        Text(
                          "details about the topic.",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
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
                      _showDetails = pixels <= 0; // hide or show to top button
                    });
                    return true;
                  },
                  child: ListView(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      const LessonNotes(
                        lessonNumber: 1,
                        lessonName: 'Flowering vs Nonflowering Plants',
                        notes:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id odio nec nisi posuere sollicitudin. Nam vitae sapien euismod, molestie velit a, viverra libero. Cras in diam feugiat, efficitur lacus non, vehicula velit. Quisque consectetur magna id purus eleifend, eget aliquet sapien sodales. Integer sed odio ac nulla congue hendrerit. Vivamus placerat enim sed vehicula tempor. Integer quis est sit amet nulla condimentum posuere a vel eros. Phasellus ac venenatis quam, a aliquet quam. Integer ac luctus metus. Nulla facilisi.',
                      ),
                      const LessonNotes(
                        lessonNumber: 2,
                        lessonName: 'Parts of Flowering Plants',
                        notes:
                            'Suspendisse euismod ultricies arcu, at tempor ligula finibus vel. Duis ut lectus leo. Proin fermentum odio et arcu efficitur, vitae scelerisque lectus bibendum. Donec faucibus eleifend erat, ut hendrerit libero rhoncus sed. Aliquam pharetra, odio sed aliquet vehicula, risus ligula sagittis mauris, nec placerat eros lacus sit amet arcu. Sed gravida quam sed urna scelerisque, nec fermentum libero sodales. Nulla facilisi. Suspendisse potenti.\n\n Sed varius, nulla sed accumsan posuere, urna libero accumsan justo, vel lacinia nulla justo ut libero. Donec maximus tortor vel posuere dignissim. Vestibulum bibendum venenatis neque, eu facilisis felis lacinia id.\n\n Maecenas sagittis nulla id dui vestibulum, vel bibendum dolor tempus. Sed lacinia massa eros, vel faucibus eros volutpat a. Vivamus sit amet lorem in est vestibulum luctus ac a dui. Sed at metus lorem. Sed varius purus libero, ac dignissim odio varius ut.',
                      ),
                      const LessonNotes(
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
                        crossFadeState: _showDetails
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
                                    duration: Duration(milliseconds: 500),
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
      ),
    );
  }
}

class LessonNotes extends StatelessWidget {
  final int lessonNumber;
  final String lessonName;
  final String notes;
  const LessonNotes(
      {super.key,
      required this.lessonNumber,
      required this.lessonName,
      required this.notes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Lesson
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // lesson number
            Text(
              "Lesson $lessonNumber : ",
              style: GoogleFonts.nunito(
                fontSize: 35.sp,
                fontWeight: FontWeight.w900,
                color: Colors.orange,
              ),
            ),
            Expanded(
              // lesson name
              child: Text(
                lessonName,
                style: GoogleFonts.nunito(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
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
          child: Text(
            notes,
            style: GoogleFonts.nunito(
              fontSize: 25.sp,
              // fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        // SizedBox(
        //   height: 10.h,
        // ),
        // edit
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.penToSquare,
                size: 30.h,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
