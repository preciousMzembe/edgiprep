import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget topicCompleteText(String text, double fontSize) {
  return Text(
    text,
    textAlign: TextAlign.end,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: const Color.fromRGBO(161, 168, 183, 1),
    ),
  );
}
