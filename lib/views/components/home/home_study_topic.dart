import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget homeStudyTopic(String name, double fontSize) {
  return Text(
    name,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: const Color.fromRGBO(79, 98, 126, 1),
    ),
  );
}
