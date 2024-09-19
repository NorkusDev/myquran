class AppConstant {
  // static String get baseUrl => const String.fromEnvironment('API_HOST');
  static String get baseUrl => "https://quran-api.santrikoding.com/api";
  // static String get env => const String.fromEnvironment('APP_ENV');
  static String get env => "development";

  static String imageAsset = "assets/images";
  static String iconAsset = "assets/icons";
}

extension AppConstantX on String {
  static bool get isDevelopment => AppConstant.env == "development";
  static bool get isProduction => AppConstant.env == "production";
}
