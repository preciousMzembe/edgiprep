class ExamModel {
  final int examId;
  final String examName;

  const ExamModel({
    required this.examId,
    required this.examName,
  });

  Map<String, dynamic> get toMap {
    return {
      'examId': examId,
      'examName': examName,
    };
  }
}
