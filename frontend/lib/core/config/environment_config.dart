
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  
  static final EnvironmentConfig instance = EnvironmentConfig._();


  EnvironmentConfig._();

  Future<void> initialize() {
    return dotenv.load();
  }

  String get apiURL => dotenv.env["API_URL"] ?? "NOT_IMPLEMENTED_API_URL";
}