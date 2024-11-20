class SubjectModel {
  String name;
  bool selected;
  String icon;

  SubjectModel({
    required this.name,
    required this.icon,
    this.selected = false,
  });

  // Method to toggle the selected state
  void toggleSelection() {
    selected = !selected;
  }

  // Factory method to create a subject from a JSON map (if needed for APIs)
  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
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
