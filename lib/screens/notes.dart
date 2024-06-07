import 'package:edgiprep/screens/subject_notes.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List newSubjectList = [];
  int _section = 1;
  int _subSection = 1;

  void changeSection(index) {
    setState(() {
      _section = index;
    });
  }

  void changeSubSection(index) {
    setState(() {
      _subSection = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final numSubLists = (subjects.length / 2).ceil();
    newSubjectList = List.generate(numSubLists, (index) {
      return subjects.sublist(
          index * 2,
          subjects.length < (index * 2) + 2
              ? subjects.length
              : (index * 2) + 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                "Organize and Review Study Materials",
                style: GoogleFonts.nunito(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              // SizedBox(
              //   height: 5.h,
              // ),
              // Text(
              //   "Organize and Review Your Materials.",
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

        // notes types
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // study guide
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    changeSection(1);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: _section == 1 ? secondaryColor : grayColor,
                      ),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipOval(
                              child: Container(
                                width: 30.h,
                                height: 30.h,
                                color:
                                    _section == 1 ? secondaryColor : grayColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Study Guide",
                          style: GoogleFonts.nunito(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),

              // my notes
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    changeSection(2);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: _section == 2 ? secondaryColor : grayColor,
                      ),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipOval(
                              child: Container(
                                width: 30.h,
                                height: 30.h,
                                color:
                                    _section == 2 ? secondaryColor : grayColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "My Notes",
                          style: GoogleFonts.nunito(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
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
        // subjects
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: ListView.separated(
              itemCount: newSubjectList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: index == 0,
                      child: SizedBox(
                        height: 30.h,
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: NotesSubject(
                              subject: "${newSubjectList[index][0][0]}",
                              image: "${newSubjectList[index][0][1]}",
                              numberOfNotes: 3,
                              like: index == 0,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: newSubjectList.length != index + 1
                                ? NotesSubject(
                                    subject: "${newSubjectList[index][1][0]}",
                                    image: "${newSubjectList[index][1][1]}",
                                    numberOfNotes: 3,
                                    like: false,
                                  )
                                : const Text(""),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: index == newSubjectList.length - 1,
                      child: SizedBox(
                        height: 80.h,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.h);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class NotesSubject extends StatelessWidget {
  final String subject;
  final int numberOfNotes;
  final String image;
  final bool like;
  const NotesSubject(
      {super.key,
      required this.subject,
      required this.numberOfNotes,
      required this.image,
      required this.like});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.r),
      child: GestureDetector(
        onTap: () {
          Get.to(() => const SubjectNotes());
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$image'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: const Color.fromARGB(210, 0, 0, 0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 30.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // image
                  Row(
                    children: [
                      Container(
                        width: 70.h,
                        height: 70.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/$image'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ],
                  ),
                  // subject
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    subject,
                    style: GoogleFonts.nunito(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // number of notes
                  Text(
                    "$numberOfNotes Topics",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromARGB(255, 197, 197, 197),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
