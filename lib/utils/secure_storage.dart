import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Write value
  Future<void> writeKey(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read value
  Future<String?> readKey(String key) async {
    return await _storage.read(key: key);
  }

  // Delete value
  Future<void> deleteKey(String key) async {
    await _storage.delete(key: key);
  }
}
