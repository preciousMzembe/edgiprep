import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget topicLessonName(String name, double fontSize) {
  return Text(
    name,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: const Color.fromRGBO(52, 74, 106, 1),
    ),
  );
}
