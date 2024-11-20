import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget subjectTopicName(String name, double fontSize) {
  return Text(
    name,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    ),
  );
}
