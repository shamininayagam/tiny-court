enum EnvironmentType {
  dev,
  prod,
  stage,
}

abstract class Environment {
  factory Environment() => _environment!;

  Environment.public();

  static Environment? _environment;

  static set env(Environment value) {
    assert(_environment == null, 'Environment can be set only once');
    _environment = value;
  }

  static Environment get env {
    if (_environment == null) {
      throw Exception('Environment is not set');
    }
    return _environment!;
  }

  bool get isStage => type == EnvironmentType.stage;

  bool get isDev => type == EnvironmentType.dev;

  bool get isProd => type == EnvironmentType.prod;

  EnvironmentType get type;

  String get scheme => 'http';

  String get host => 'localhost';

  int? get port => 8080;

  bool get useEmulator => false;

  // FirebaseOptions get firebaseOptions;

  String get baseURL => '$scheme://$host${port != null ? ':$port' : ''}';

  int get defaultAppLockTimeout => 10;
}
