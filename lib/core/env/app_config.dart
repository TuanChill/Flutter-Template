import 'package:flutter/services.dart';

enum Flavor {
  development,
  staging,
  production,
}

class AppConfig {
  static late Flavor _flavor;
  static late String _baseUrl;

  static Flavor get flavor => _flavor;
  static String get baseUrl => _baseUrl;

  static Future<void> initialize(Flavor flavor) async {
    _flavor = flavor;

    // Load the appropriate .env file based on flavor
    final envFile = _getEnvFileName(flavor);
    final envString = await rootBundle.loadString(envFile);

    // Parse the .env content manually
    final envVars = _parseEnvString(envString);
    _baseUrl = envVars['API_URL'] ?? 'https://default.api.com';
  }

  static String _getEnvFileName(Flavor flavor) {
    switch (flavor) {
      case Flavor.development:
        return '.env.development';
      case Flavor.staging:
        return '.env.staging';
      case Flavor.production:
        return '.env.production';
    }
  }

  static Map<String, String> _parseEnvString(String envString) {
    final Map<String, String> envVars = {};
    final lines = envString.split('\n');

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;

      final parts = trimmed.split('=');
      if (parts.length == 2) {
        envVars[parts[0].trim()] = parts[1].trim();
      }
    }

    return envVars;
  }
}