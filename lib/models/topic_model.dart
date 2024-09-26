class TopicModel {
  final int topicId;
  final String topicName;
  final String topicColor;
  final int slidesNumber;
  final int slidesDone;

  const TopicModel({
    required this.topicId,
    required this.topicName,
    required this.topicColor,
    required this.slidesNumber,
    required this.slidesDone,
  });

  Map<String, dynamic> get toMap {
    return {
      'topicId': topicId,
      'topicName': topicName,
      'topicColor': topicColor,
      'slidesNumber': slidesNumber,
      'slidesDone': slidesDone,
    };
  }
}
