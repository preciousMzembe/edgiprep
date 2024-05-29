import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';

class TestTab extends StatefulWidget {
  const TestTab({super.key});

  @override
  State<TestTab> createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
    );
  }
}
