import 'package:edgiprep/models/lesson/slide_model.dart';

class LessonModel {
  final String id;
  final String title;
  final List<SlideModel> slides;

  LessonModel({required this.id, required this.title, required this.slides});
}
