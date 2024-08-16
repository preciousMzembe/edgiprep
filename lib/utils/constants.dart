import 'dart:math';

import 'package:flutter/material.dart';

const appName = "EdgiPrep";

// Color primaryColor = const Color.fromRGBO(3, 91, 205, 1);
Color primaryColor = const Color.fromRGBO(47, 59, 98, 1);
Color progressColor = const Color.fromRGBO(47, 59, 98, 0.404);
Color secondaryColor = const Color.fromRGBO(243, 188, 92, 1);
Color grayColor = const Color.fromARGB(92, 141, 141, 141);
Color shadowColor = const Color.fromRGBO(0, 71, 163, 1);
Color backgroundColor = Colors.white;
Color textColor = const Color.fromARGB(255, 119, 119, 119);
Color accentColor = const Color.fromRGBO(255, 193, 7, 1);
Color errorColor = const Color.fromRGBO(220, 53, 69, 1);

List subjects = [
  ["Biology", "biology.jpg"],
  ["History", "history.jpg"],
  ["Geography", "geography.jpg"],
  ["Chemistry", "science.jpg"],
  ["Agriculture", "agriculture.jpg"],
];

List exams = ["JE", "ME"];

Color getRandomColor() {
  final random = Random();
  final red = random.nextInt(256);
  final green = random.nextInt(256);
  final blue = random.nextInt(256);
  return Color.fromRGBO(red, green, blue, 1.0);
}
