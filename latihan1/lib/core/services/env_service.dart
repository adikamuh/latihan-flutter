class EnvService {
  EnvService._internal();

  static String? _baseUrl;
  static String? _geoapifyApiKey;

  static Future<void> init() async {
    _baseUrl = const String.fromEnvironment('BASE_URL');
    _geoapifyApiKey = const String.fromEnvironment('Geoapify_API_KEY');
  }

  static String get baseUrl {
    if (_baseUrl == null) {
      throw Exception('Base URL is not set. Call EnvService.init() first.');
    }
    return _baseUrl!;
  }

  static String get geoapifyApiKey {
    if (_geoapifyApiKey == null) {
      throw Exception(
        'Geoapify API Key is not set. Call EnvService.init() first.',
      );
    }
    return _geoapifyApiKey!;
  }
}
