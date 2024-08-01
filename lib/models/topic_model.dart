import 'package:flutter/material.dart';

class TopicModel {
  final int topicId;
  final String topicName;
  final Color topicColor;

  const TopicModel({
    required this.topicId,
    required this.topicName,
    required this.topicColor,
  });

  Map<String, dynamic> get toMap {
    return {
      'topicId': topicId,
      'topicName': topicName,
      'topicColor': topicColor,
    };
  }
}
