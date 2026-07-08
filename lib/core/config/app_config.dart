class AppConfig {
  // Keep these in one place.
  // NOTE: You must replace the token with the real APP_AUTH_TOKEN obtained from the backend owner.
  static const String appAuthToken = String.fromEnvironment(
    'APP_AUTH_TOKEN',
    defaultValue: '47ca0305433c596d8e9990af06adcc09a967',
  );

  static const String baseUrl = 'https://gwinbayin.com';
  static const String appVersion = '1.0.0';
  static const String appUserAgent = 'GwinBayinApp';

  // CDN / streaming assets
  static const String cdnBaseUrl = 'https://cdn.gwinbayin.com';
}

