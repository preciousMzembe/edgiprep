import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget homeStudySubject(String name, double fontSize) {
  return Text(
    name,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: primaryColor,
      height: 1,
    ),
  );
}
