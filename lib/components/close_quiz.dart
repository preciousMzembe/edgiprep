import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CloseQuizPane extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function close;
  const CloseQuizPane(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.close});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                width: 180.h,
                height: 180.h,
                child: Center(
                  child: ClipOval(
                    child: Container(
                      color: const Color.fromARGB(57, 244, 67, 54),
                      padding: EdgeInsets.all(
                        40.w,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.faceFrownOpen,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 180.h,
                height: 180.h,
                child: Center(
                  child: Container(
                    width: 145.h,
                    height: 145.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(85, 244, 67, 54),
                      borderRadius: BorderRadius.circular(140.r),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                fontSize: 40.sp,
                fontWeight: FontWeight.w900,
                color: primaryColor),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600),
          ),

          // close
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 60.h,
                    width: 200.w,
                    color: grayColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: const Center(
                      child: Text("Cancel"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: GestureDetector(
                  onTap: () {
                    close();
                  },
                  child: Container(
                    height: 60.h,
                    width: 200.w,
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: const Center(
                      child: Text(
                        "Quit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
