class EnvService {
  EnvService._internal();

  static String? _baseUrl;
  static String? _geocodingApiKey;

  static Future<void> init() async {
    _baseUrl = const String.fromEnvironment('BASE_URL');
    _geocodingApiKey = const String.fromEnvironment('GEOCODING_API_KEY');
  }

  static String get baseUrl {
    if (_baseUrl == null) {
      throw Exception('Base URL is not set. Call EnvService.init() first.');
    }
    return _baseUrl!;
  }

  static String get geocodingApiKey {
    if (_geocodingApiKey == null) {
      throw Exception(
        'Geocoding API Key is not set. Call EnvService.init() first.',
      );
    }
    return _geocodingApiKey!;
  }
}
