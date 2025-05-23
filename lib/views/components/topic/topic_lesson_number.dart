import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget topicLessonNumber(String name, double fontSize, String color) {
  return Text(
    name,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: getBackgroundColorFromString(color),
      height: 1,
    ),
  );
}
