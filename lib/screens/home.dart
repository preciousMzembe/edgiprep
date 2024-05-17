import 'package:edgiprep/components/daily_practice.dart';
import 'package:edgiprep/components/recent_progress.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          "Precious",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // notification and profile
                  SizedBox(
                    width: 20.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90.h,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              90.r,
                            ),
                          ),
                          color: primaryColor,
                          height: 90.h,
                          onPressed: () {},
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.solidBell,
                              size: 30.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 90.h,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              90.r,
                            ),
                          ),
                          color: primaryColor,
                          height: 90.h,
                          onPressed: () {},
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.solidUser,
                              size: 30.h,
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

            // streaks
            SizedBox(
              height: 45.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: Text(
                "Do Not Miss Practice to Maintain Your Streak.",
                style: GoogleFonts.nunito(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "expand",
                    style: GoogleFonts.nunito(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // sun
                  Expanded(
                    child: Center(
                      child: DayStreak(
                        day: "S",
                        done: true,
                      ),
                    ),
                  ),
                  // mon
                  Expanded(
                    child: Center(
                      child: DayStreak(
                        day: "M",
                        done: true,
                      ),
                    ),
                  ),
                  // tue
                  Expanded(
                    child: Center(
                      child: DayStreak(
                        day: "Today",
                        done: true,
                      ),
                    ),
                  ),
                  // wed
                  Expanded(
                    child: Center(
                      child: DayStreak(
                        day: "W",
                        done: false,
                      ),
                    ),
                  ),
                  // thu
                  Expanded(
                    child: Center(
                      child: DayStreak(
                        day: "T",
                        done: false,
                      ),
                    ),
                  ),
                  // fri
                  Expanded(
                    child: Center(
                      child: DayStreak(
                        day: "F",
                        done: false,
                      ),
                    ),
                  ),
                  // sat
                  Expanded(
                    child: Center(
                      child: DayStreak(
                        day: "S",
                        done: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // xps
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.h,
                  vertical: 50.h,
                ),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "2000 XP",
                      style: GoogleFonts.nunito(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "Practice more to boost your XP",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        // color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // daily
            SizedBox(
              height: 50.h,
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: const DailyPractice(),
              ),
            ),

            // recent
            Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: const RecentProgress(),
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

class DayStreak extends StatelessWidget {
  final String day;
  final bool done;
  const DayStreak({super.key, required this.day, required this.done});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 60.h,
          height: 60.h,
          decoration: BoxDecoration(
            border: Border.all(
                color: done ? secondaryColor : grayColor, width: 2.0),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: Icon(
              FontAwesomeIcons.check,
              size: 30.h,
              color: done ? secondaryColor : grayColor,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(day),
      ],
    );
  }
}
