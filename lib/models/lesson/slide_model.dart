import 'package:edgiprep/models/lesson/slide_content_model.dart';
import 'package:edgiprep/models/lesson/lesson_slide_question_model.dart';

class SlideModel {
  final String? id;
  final SlideContentModel? content;
  final LessonSlideQuestionModel? question;
  bool slideDone;

  SlideModel({
    this.id,
    this.content,
    this.question,
    this.slideDone = false,
  });

  toJson() => {
        'id': id,
        'content': content?.toJson(),
        'question': question?.toJson(),
        'slideDone': slideDone,
      };
}
