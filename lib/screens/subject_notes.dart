import 'package:edgiprep/screens/topic_notes.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectNotes extends StatefulWidget {
  const SubjectNotes({super.key});

  @override
  State<SubjectNotes> createState() => _SubjectNotesState();
}

class _SubjectNotesState extends State<SubjectNotes> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      "Biology",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  // image
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    width: 50.h,
                    height: 50.h,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('images/biology.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // search
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextField(
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  fillColor: grayColor,
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: 50.w,
                      right: 30.w,
                    ),
                    child: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Color.fromARGB(255, 139, 139, 139),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: grayColor,
                      // color: Color.fromARGB(255, 139, 139, 139),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: grayColor,
                      // color: Color.fromARGB(255, 139, 139, 139),
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Search',
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),

            // subjects
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
                      NotesTopic(
                        topic: "Research skills",
                        color: getRandomColor(),
                        lessons: 6,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      NotesTopic(
                        topic: "Plants Biology",
                        color: getRandomColor(),
                        lessons: 9,
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

class NotesTopic extends StatelessWidget {
  final String topic;
  final Color color;
  final int lessons;
  const NotesTopic({super.key, required this.topic, required this.color, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const TopicNotes());
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.w,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(231, 231, 231, 1),
            border: Border(
              left: BorderSide(
                width: 5,
                color: color,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  topic
                    Text(
                      topic,
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "$lessons lessons",
                      style: GoogleFonts.nunito(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Icon(
                  FontAwesomeIcons.angleRight,
                  size: 30.h,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
