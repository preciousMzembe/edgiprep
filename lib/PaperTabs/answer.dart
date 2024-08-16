import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Answer extends StatelessWidget {
  final String answer;
  final bool selected;
  final Color color;
  final Function select;
  const Answer({
    super.key,
    required this.answer,
    required this.selected,
    required this.select,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        select();
      },
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 30.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          width: 2.0,
          color: color == Colors.transparent
              ? selected
                  ? secondaryColor
                  : grayColor
              : color,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              answer,
              style: GoogleFonts.nunito(
                fontSize: 25.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            width: 35.h,
            height: 35.h,
            decoration: BoxDecoration(
              color: color == Colors.transparent
                  ? selected
                      ? secondaryColor
                      : Colors.transparent
                  : color,
              border: Border.all(
                  width: 1, color: selected ? secondaryColor : grayColor),
              borderRadius: BorderRadius.circular(35.r),
            ),
          ),
        ],
      ),
    );
  }
}
