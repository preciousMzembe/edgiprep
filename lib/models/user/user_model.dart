class UserModel {
  final String name;
  final String email;
  int xp;
  int streak;
  double weeklyProgress;
  String accountType;

  UserModel({
    required this.name,
    required this.email,
    this.xp = 0,
    this.streak = 0,
    this.weeklyProgress = 0.0,
    this.accountType = 'basic',
  });

  // Factory method to create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      xp: json['xp'] ?? 0,
      streak: json['streak'] ?? 0,
      weeklyProgress: json['weeklyProgress']?.toDouble() ?? 0.0,
      accountType: json['accountType'] ?? 'basic',
    );
  }

  // Method to convert User to JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'xp': xp,
      'streak': streak,
      'weeklyProgress': weeklyProgress,
      'accountType': accountType,
    };
  }

  // Method to increment XP
  void addXp(int points) {
    xp += points;
  }

  // Method to increment streak
  void incrementStreak() {
    streak += 1;
  }
}
