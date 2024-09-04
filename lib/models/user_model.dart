class UserModel {
  final int userId;
  final String fullName;
  final String username;
  final int xps;

  const UserModel({
    required this.userId,
    required this.fullName,
    required this.username,
    required this.xps,
  });

  Map<String, dynamic> get toMap {
    return {
      'userId': userId,
      'fullName': fullName,
      'username': username,
      'xps': xps,
    };
  }
}
