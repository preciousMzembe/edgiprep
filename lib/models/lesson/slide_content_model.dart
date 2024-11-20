import 'package:edgiprep/models/lesson/slide_media_model.dart';

class SlideContentModel {
  final String title;
  final String? text;
  final SlideMediaModel? slideMedia;

  SlideContentModel({
    required this.title,
    this.slideMedia,
    this.text,
  });
}
