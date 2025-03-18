import 'package:flutter/material.dart';

const appName = "Open Events";

Color primaryColor = const Color.fromRGBO(35, 131, 226, 1);
Color backgroundColor = const Color.fromRGBO(236, 239, 245, 1);
Color primaryTextColor = Colors.white;
Color secondaryTextColor = const Color.fromRGBO(97, 97, 97, 1);

Color successColor = const Color.fromRGBO(102, 203, 124, 1);
Color errorColor = const Color.fromRGBO(254, 101, 93, 1);

Color appbarColor = const Color.fromRGBO(35, 131, 226, 1);

// enrollment
Color selectedExamColor = const Color.fromRGBO(104, 180, 255, 1);
Color unselectedExamColor = const Color.fromRGBO(92, 101, 120, 1);
Color unselectedButtonColor = const Color.fromRGBO(214, 220, 233, 1);

// navigation
Color unselectedNavOptionColor = const Color.fromRGBO(161, 168, 183, 1);

// home
Color homeFadeColor = const Color.fromRGBO(147, 152, 159, 1);
Color homeLightBackgroundColor = const Color.fromRGBO(193, 224, 255, 1);

Color getColorFromString(String colorString) {
  final regex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
  final match = regex.firstMatch(colorString);

  if (match != null) {
    int red = int.parse(match.group(1)!);
    int green = int.parse(match.group(2)!);
    int blue = int.parse(match.group(3)!);

    return Color.fromRGBO(red, green, blue, 1);
  } else {
    return primaryColor;
  }
}

Color getFadeColorFromString(String colorString) {
  final regex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
  final match = regex.firstMatch(colorString);

  if (match != null) {
    int red = int.parse(match.group(1)!);
    int green = int.parse(match.group(2)!);
    int blue = int.parse(match.group(3)!);

    return Color.fromRGBO(red, green, blue, .5);
  } else {
    return primaryColor;
  }
}

Color getBackgroundColorFromString(String colorString) {
  final regex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
  final match = regex.firstMatch(colorString);

  if (match != null) {
    int red = int.parse(match.group(1)!);
    int green = int.parse(match.group(2)!);
    int blue = int.parse(match.group(3)!);

    return Color.fromRGBO(red, green, blue, .8);
  } else {
    return primaryColor;
  }
}

String capitalizeWords(String text) {
  return text.split(" ").map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join(" ");
}
