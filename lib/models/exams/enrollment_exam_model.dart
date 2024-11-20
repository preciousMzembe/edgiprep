class EnrollmentExamModel {
  String id;
  String name;
  bool selected;

  EnrollmentExamModel({
    required this.id,
    required this.name,
    this.selected = false,
  });

  // Factory constructor to create an instance from JSON
  factory EnrollmentExamModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentExamModel(
      id: json['id'],
      name: json['name'],
      selected: json['selected'] ?? false,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'selected': selected,
    };
  }
}
