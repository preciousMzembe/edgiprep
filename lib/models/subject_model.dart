class SubjectModel {
  final int subjectId;
  final String subjectName;
  final String subjectDescription;
  final String subjectImage;
  final int slidesNumber;
  final int slidesDone;

  const SubjectModel({
    required this.subjectId,
    required this.subjectName,
    required this.subjectDescription,
    required this.subjectImage,
    required this.slidesNumber,
    required this.slidesDone,
  });

  Map<String, dynamic> get toMap {
    return {
      'subjectId': subjectId,
      'subjectName': subjectName,
      'subjectDescription': subjectDescription,
      'subjectImage': subjectImage,
      'slidesNumber': slidesNumber,
      'slidesDone': slidesDone,
    };
  }
}
