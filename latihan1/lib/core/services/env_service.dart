class EnvService {
  EnvService._internal();

  static String? _baseUrl;

  static Future<void> init() async {
    _baseUrl = const String.fromEnvironment('BASE_URL');
  }

  static String get baseUrl {
    if (_baseUrl == null) {
      throw Exception('Base URL is not set. Call EnvService.init() first.');
    }
    return _baseUrl!;
  }
}
