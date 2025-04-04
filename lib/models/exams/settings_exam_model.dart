class SettingsExamModel {
  String id;
  String enrollmentId;
  String name;
  bool selected;

  SettingsExamModel({
    required this.id,
    required this.enrollmentId,
    required this.name,
    this.selected = false,
  });

  // Factory constructor to create an instance from JSON
  factory SettingsExamModel.fromJson(Map<String, dynamic> json) {
    return SettingsExamModel(
      id: json['id'],
      enrollmentId: json['enrollmentId'],
      name: json['name'],
      selected: json['selected'] ?? false,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enrollmentId': enrollmentId,
      'name': name,
      'selected': selected,
    };
  }
}
