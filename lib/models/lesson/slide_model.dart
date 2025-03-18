import 'package:edgiprep/models/lesson/slide_content_model.dart';
import 'package:edgiprep/models/lesson/lesson_slide_question_model.dart';

class SlideModel {
  final SlideContentModel? content;
  final LessonSlideQuestionModel? question;
  bool slideDone;

  SlideModel({
    this.content,
    this.question,
    this.slideDone = false,
  });

  toJson() => {
        'content': content?.toJson(),
        'question': question?.toJson(),
        'slideDone': slideDone,
      };
}
