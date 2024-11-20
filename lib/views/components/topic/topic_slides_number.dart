import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget topicSlidesNumber(String name, Color color, double fontSize) {
  return Text(
    name,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}
