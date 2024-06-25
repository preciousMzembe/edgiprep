import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Papers extends StatelessWidget {
  final String subject;
  const Papers({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // top
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
                          subject,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // search
                SizedBox(
                  height: isTall ? 30.h : 50.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTall ? 30.w : 50.h,
                  ),
                  child: TextField(
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      fillColor: grayColor,
                      filled: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: isTall ? 50.w : 25.w,
                          right: isTall ? 30.w : 20.w,
                        ),
                        child: Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: const Color.fromARGB(255, 139, 139, 139),
                          size: isTall ? 30.h : 50.h,
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
                      contentPadding: EdgeInsets.symmetric(
                        vertical: isTall ? 25.h : 35.h,
                      ),
                      hintStyle: TextStyle(
                        fontSize: isTall ? 30.sp : 15.sp,
                      ),
                      hintText: 'Search',
                    ),
                    style: TextStyle(
                      fontSize: isTall ? 30.sp : 15.sp,
                    ),
                  ),
                ),

                // list of papers
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        const Paper(
                          name: "2020 MANEB",
                          date: "March 20, 2020",
                          time: "2 hours",
                          done: true,
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        const Paper(
                          name: "2021 MANEB",
                          date: "March 20, 2021",
                          time: "2 hours",
                          done: false,
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        const Paper(
                          name: "2022 MANEB",
                          date: "March 20, 2022",
                          time: "2 hours",
                          done: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Paper extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final bool done;
  const Paper(
      {super.key,
      required this.name,
      required this.date,
      required this.time,
      required this.done});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // line
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              ClipOval(
                child: Container(
                  width: 20.h,
                  height: 20.h,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: Container(
                  width: 3.h,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          // details
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // name and done
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFonts.nunito(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    // done
                    SizedBox(
                      width: 10.w,
                    ),
                    ClipOval(
                      child: Container(
                        width: 30.h,
                        height: 30.h,
                        color: done ? primaryColor : grayColor,
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 15.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                // details
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.nunito(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      const TextSpan(text: "Held on:  "),
                      TextSpan(
                        text: date,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: "   |   ",
                        style: TextStyle(color: textColor),
                      ),
                      const TextSpan(text: "Duration:  "),
                      TextSpan(
                        text: time,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                if (done)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.nunito(
                            color: textColor,
                          ),
                          children: [
                            const TextSpan(text: "Previous Score:  "),
                            TextSpan(
                              text: "30%",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
