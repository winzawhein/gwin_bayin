import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';

final appAuthTokenProvider = Provider<String>((ref) {
  return AppConfig.appAuthToken;
});

