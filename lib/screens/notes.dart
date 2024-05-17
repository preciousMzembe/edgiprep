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
                "Your Notes",
                style: GoogleFonts.nunito(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Here are your notes.",
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
          height: 25.h,
        ),

        // subjects
        Visibility(
          visible: true,
          child: Expanded(
            child: GridView.count(
              primary: false,
              padding: EdgeInsets.only(
                top: 10.h,
                left: 30.w,
                right: 30.w,
                bottom: 100.h,
              ),
              crossAxisSpacing: 20.h,
              mainAxisSpacing: 20.h,
              crossAxisCount: 2,
              children: const [
                NotesSubject(
                  subject: "Biology",
                  numberOfNotes: 4,
                ),
                NotesSubject(
                  subject: "Social Studies",
                  numberOfNotes: 8,
                ),
                NotesSubject(
                  subject: "History",
                  numberOfNotes: 8,
                ),
              ],
            ),
          ),
        ),

        // no notes
        Visibility(
          visible: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Icon(
                  FontAwesomeIcons.filePen,
                  size: 80.h,
                  color: grayColor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "You have no notes",
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    "Write notes after a leason to add them here.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 40.sp,
                      color: textColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
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
  const NotesSubject(
      {super.key, required this.subject, required this.numberOfNotes});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Get.to(() => const SubjectNotes());
      },
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(40.r),
      // ),
      // padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.folderMinus,
            size: 50.h,
            color: secondaryColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          // subject
          Text(
            subject,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: 35.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          // number of notes
          Text(
            "$numberOfNotes Topics",
            style: TextStyle(
              fontSize: 20.sp,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
