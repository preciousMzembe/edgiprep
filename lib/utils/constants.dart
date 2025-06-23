import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

const appName = "EdgiPrep";
const androidId = "com.edgicate.edgiprep";
const playStoreLink =
    "https://play.google.com/store/apps/details?id=$androidId";

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

void setWhiteStatusBarIcons() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // For Android (white icons)
      statusBarBrightness: Brightness.dark,      // For iOS (white icons)
    ),
  );
}


Color getColorFromString(String colorString) {
  // Match rgb
  final rgbRegex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
  final rgbMatch = rgbRegex.firstMatch(colorString);

  if (rgbMatch != null) {
    int red = int.parse(rgbMatch.group(1)!);
    int green = int.parse(rgbMatch.group(2)!);
    int blue = int.parse(rgbMatch.group(3)!);
    return Color.fromRGBO(red, green, blue, 1);
  }

  // Match hex
  final hexRegex = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  if (hexRegex.hasMatch(colorString)) {
    String hex = colorString.replaceFirst('#', '');

    final red = int.parse(hex.substring(0, 2), radix: 16);
    final green = int.parse(hex.substring(2, 4), radix: 16);
    final blue = int.parse(hex.substring(4, 6), radix: 16);

    return Color.fromRGBO(red, green, blue, 1);
  }

  // Fallback
  return primaryColor;
}

Color getFadeColorFromString(String colorString) {
  double brightnessFactor = 0.5; // increase brightness by 20%

  // Helper to brighten a single color channel
  int brighten(int value) {
    return (value + ((255 - value) * brightnessFactor)).round().clamp(0, 255);
  }

  // Match rgb
  final rgbRegex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
  final rgbMatch = rgbRegex.firstMatch(colorString);

  if (rgbMatch != null) {
    int red = brighten(int.parse(rgbMatch.group(1)!));
    int green = brighten(int.parse(rgbMatch.group(2)!));
    int blue = brighten(int.parse(rgbMatch.group(3)!));
    return Color.fromRGBO(red, green, blue, 1);
  }

  // Match hex
  final hexRegex = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  if (hexRegex.hasMatch(colorString)) {
    String hex = colorString.replaceFirst('#', '');

    final red = brighten(int.parse(hex.substring(0, 2), radix: 16));
    final green = brighten(int.parse(hex.substring(2, 4), radix: 16));
    final blue = brighten(int.parse(hex.substring(4, 6), radix: 16));

    return Color.fromRGBO(red, green, blue, 1);
  }

  // Fallback
  return primaryColor;
}

Color getMoreFadeColorFromString(String colorString) {
  double brightnessFactor = 0.6; // increase brightness by 20%

  // Helper to brighten a single color channel
  int brighten(int value) {
    return (value + ((255 - value) * brightnessFactor)).round().clamp(0, 255);
  }

  // Match rgb
  final rgbRegex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
  final rgbMatch = rgbRegex.firstMatch(colorString);

  if (rgbMatch != null) {
    int red = brighten(int.parse(rgbMatch.group(1)!));
    int green = brighten(int.parse(rgbMatch.group(2)!));
    int blue = brighten(int.parse(rgbMatch.group(3)!));
    return Color.fromRGBO(red, green, blue, 1);
  }

  // Match hex
  final hexRegex = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  if (hexRegex.hasMatch(colorString)) {
    String hex = colorString.replaceFirst('#', '');

    final red = brighten(int.parse(hex.substring(0, 2), radix: 16));
    final green = brighten(int.parse(hex.substring(2, 4), radix: 16));
    final blue = brighten(int.parse(hex.substring(4, 6), radix: 16));

    return Color.fromRGBO(red, green, blue, 1);
  }

  // Fallback
  return primaryColor;
}

Color getBackgroundColorFromString(String colorString) {
  double brightnessFactor = 0.8; // 80% of original brightness

  // Match rgb
  final rgbRegex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
  final rgbMatch = rgbRegex.firstMatch(colorString);

  if (rgbMatch != null) {
    int red = (int.parse(rgbMatch.group(1)!) * brightnessFactor).round();
    int green = (int.parse(rgbMatch.group(2)!) * brightnessFactor).round();
    int blue = (int.parse(rgbMatch.group(3)!) * brightnessFactor).round();
    return Color.fromRGBO(red, green, blue, 1);
  }

  // Match hex
  final hexRegex = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  if (hexRegex.hasMatch(colorString)) {
    String hex = colorString.replaceFirst('#', '');

    final red =
        (int.parse(hex.substring(0, 2), radix: 16) * brightnessFactor).round();
    final green =
        (int.parse(hex.substring(2, 4), radix: 16) * brightnessFactor).round();
    final blue =
        (int.parse(hex.substring(4, 6), radix: 16) * brightnessFactor).round();

    return Color.fromRGBO(red, green, blue, 1);
  }

  // Fallback
  return primaryColor;
}

String capitalizeWords(String text) {
  return text.split(" ").map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join(" ");
}

Future<String> getCurrentVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
