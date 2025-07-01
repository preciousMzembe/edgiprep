import 'package:edgiprep/models/lesson/slide_model.dart';
import 'package:edgiprep/views/components/challenge/challenge_question.dart';
import 'package:edgiprep/views/components/lesson/lesson_content.dart';
import 'package:edgiprep/views/components/lesson/lesson_question.dart';
import 'package:edgiprep/views/components/mock/mock_question.dart';
import 'package:edgiprep/views/components/paper/paper_question.dart';
import 'package:edgiprep/views/components/quiz/quiz_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonSlide extends StatelessWidget {
  final SlideModel slide;
  final String type;

  const LessonSlide({
    super.key,
    required this.slide,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SizedBox(
          height: 40.h,
        ),
        if (slide.content != null &&
            (slide.content!.title != "" ||
                slide.content!.text != "" ||
                slide.content!.slideMedia != null))
          lessonContent(slide.content),

        if (slide.question != null)
          type == "lesson"
              ? lessonQuestion(slide.question, slide.slideDone)
              : type == "quiz"
                  ? quizQuestion(slide.question, slide.slideDone)
                  : type == "paper"
                      ? paperQuestion(slide.question, slide.slideDone)
                      : type == "mock"
                          ? mockQuestion(slide.question, slide.slideDone)
                          : challengeQuestion(slide.question, slide.slideDone),

        // bottom
        SizedBox(
          height: 100.h,
        ),
      ],
    );
  }
}
