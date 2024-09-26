class UserModel {
  final int userId;
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final int xps;
  final int streaks;

  const UserModel({
    required this.userId,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.xps,
    required this.streaks,
  });

  Map<String, dynamic> get toMap {
    return {
      'userId': userId,
      'fullName': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'xps': xps,
      'streaks': streaks,
    };
  }
}
