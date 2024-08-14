class PaperModel {
  final int paperId;
  final String paperName;
  final String paperDate;
  final String paperDuration;
  final bool paperDone;

  const PaperModel({
    required this.paperId,
    required this.paperName,
    required this.paperDate,
    required this.paperDuration,
    required this.paperDone,
  });

  Map<String, dynamic> get toMap {
    return {
      'paperId': paperId,
      'paperName': paperName,
      'paperDate': paperDate,
      'paperDuration': paperDuration,
      'paperDone': paperDone,
    };
  }
}
