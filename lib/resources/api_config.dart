class ApiConfig {
  static ApiConfig? _instance;

  factory ApiConfig() => _instance ??= ApiConfig._();

  ApiConfig._();

  String get appConfig {
    const String staginUrl =
        'https://staging.api.mm-evryvillage.fr/world_cup/public/api/';
    return staginUrl;
  }

  String get authConfig {
    const String staginUrl =
        'https://staging.api.mm-evryvillage.fr/world_cup/public/api/';
    return staginUrl;
  }
}
