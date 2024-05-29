import 'package:edgiprep/screens/subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  List newSubjectList = [];
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
            padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                            child: LearnSubject(
                              subject: "${newSubjectList[index][0][0]}",
                              image: "${newSubjectList[index][0][1]}",
                              percent: .4,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: newSubjectList.length != index + 1
                                ? LearnSubject(
                                    subject: "${newSubjectList[index][1][0]}",
                                    image: "${newSubjectList[index][1][1]}",
                                    percent: .6,
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

class LearnSubject extends StatefulWidget {
  final String subject;
  final double percent;
  final String image;
  const LearnSubject(
      {super.key,
      required this.subject,
      required this.percent,
      required this.image});

  @override
  State<LearnSubject> createState() => _LearnSubjectState();
}

class _LearnSubjectState extends State<LearnSubject> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: GestureDetector(
        onTap: () {
          // Get.to(() => const Subject());
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/${widget.image}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 30.w,
            ),
            color: const Color.fromARGB(210, 0, 0, 0),
            child: Column(
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
                          image: AssetImage('images/${widget.image}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ],
                ),

                // name and progress
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // name and topics
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          // name
                          Text(
                            widget.subject,
                            style: GoogleFonts.nunito(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          // topics
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "24 Topics",
                                style: GoogleFonts.nunito(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      const Color.fromARGB(255, 197, 197, 197),
                                ),
                              ),
                              // progress
                              SizedBox(
                                width: 70.h,
                                height: 70.h,
                                child: CircularPercentIndicator(
                                  radius: 35.h,
                                  percent: widget.percent,
                                  progressColor: secondaryColor,
                                  lineWidth: 3.0,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  backgroundColor: progressColor,
                                  startAngle: 270,
                                  animation: true,
                                  center: Text(
                                    "${(widget.percent * 100).toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
