import 'package:edgiprep/responsive/web_layout.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget body;
  const ResponsiveLayout({super.key, required this.body});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIsWeb ? backgroundColor : appbarColor,
      body: kIsWeb ? WebLayout(body: widget.body) : widget.body,
    );
  }
}
