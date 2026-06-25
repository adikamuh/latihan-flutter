import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPrefService? _instance;
  SharedPrefService._();
  static late final SharedPreferences? _prefs;

  static SharedPreferences get pref {
    if (_prefs == null || _instance == null) {
      throw Exception(
        'SharedPrefService is not initialized. Please call SharedPrefService.init() first.',
      );
    }
    return _prefs!;
  }

  static Future<void> init() async {
    _instance = SharedPrefService._();
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
