class EnrollmentSubjectModel {
  String id;
  String name;
  bool selected;
  String icon;

  EnrollmentSubjectModel({
    required this.id,
    required this.name,
    required this.icon,
    this.selected = false,
  });

  // Method to toggle the selected state
  void toggleSelection() {
    selected = !selected;
  }

  // Factory method to create a subject from a JSON map (if needed for APIs)
  factory EnrollmentSubjectModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentSubjectModel(
      id: json['id'],
      name: json['name'],
      selected: json['selected'] ?? false,
      icon: json['icon'] ?? "biology.svg",
    );
  }

  // Method to convert a EnrollmentSubject to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'selected': selected,
      'icon': icon,
    };
  }
}
