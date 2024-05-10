import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.staging';
  }

  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? 'Base Url not found';
  }

}
