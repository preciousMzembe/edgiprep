import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Lesson extends StatefulWidget {
  const Lesson({super.key});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return ListView(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Text("top"),
                      SizedBox(
                        height: 2000,
                      ),
                      Text("bottom"),
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Child with min height as full height',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class LessonQuestion extends StatelessWidget {
  const LessonQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
