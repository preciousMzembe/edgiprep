class SubjectModel {
  final int subjectId;
  final String subjectName;
  final String subjectDescription;
  final String subjectImage;

  const SubjectModel({
    required this.subjectId,
    required this.subjectName,
    required this.subjectDescription,
    required this.subjectImage,
  });

  Map<String, dynamic> get toMap {
    return {
      'subjectId': subjectId,
      'subjectName': subjectName,
      'subjectDescription': subjectDescription,
      'subjectImage': subjectImage,
    };
  }
}
