import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget homeStudyTopicsNumber(String name, double fontSize) {
  return Text(
    name,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: const Color.fromRGBO(161, 168, 183, 1),
    ),
  );
}
