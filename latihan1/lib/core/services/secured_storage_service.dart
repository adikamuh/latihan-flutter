import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorageService {
  static final _secureStorage = const FlutterSecureStorage();

  static Future<void> writeValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<T?> readValue<T>({
    required String key,
    required T Function(String value) fromString,
  }) async {
    String? storedValue = await _secureStorage.read(key: key);
    if (storedValue == null) return null;
    return fromString(storedValue);
  }

  static Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
