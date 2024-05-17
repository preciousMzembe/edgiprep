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
                            "Biology Notes",
                            style: GoogleFonts.nunito(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          Text(
                            "Here are all your Biology notes.",
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
                )),
            SizedBox(
              height: 35.h,
            ),
            // search
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextField(
                cursorColor: primaryColor,
                decoration: InputDecoration(
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
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide(
                      color: primaryColor,
                      // color: Color.fromARGB(255, 139, 139, 139),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide(
                      color: primaryColor,
                      // color: Color.fromARGB(255, 139, 139, 139),
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Search topic',
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
                      const NotesTopic(
                        topic: "Research skills",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const NotesTopic(
                        topic: "Plants Biology",
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

class NotesTopic extends StatefulWidget {
  final String topic;
  const NotesTopic({super.key, required this.topic});

  @override
  State<NotesTopic> createState() => _NotesTopicState();
}

class _NotesTopicState extends State<NotesTopic> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Get.to(() => const TopicNotes());
      },
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 40.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  topic
                    Text(
                      widget.topic,
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Icon(
                  FontAwesomeIcons.anglesRight,
                  size: 30.h,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
