// import 'package:better_player_plus/better_player_plus.dart';
// import 'package:flutter/material.dart';

// class GlobalVideoManager {
//   static final GlobalVideoManager _instance = GlobalVideoManager._internal();
//   factory GlobalVideoManager() => _instance;
//   GlobalVideoManager._internal();

//   BetterPlayerController? _currentController;
//   String? _currentUrl;

//   BetterPlayerController? get currentController => _currentController;

//   BetterPlayerController getOrCreateController(String url, String title) {
//     if (_currentController != null && _currentUrl == url) {
//       return _currentController!;
//     }

//     // Notice: We don't blindly dispose here anymore to prevent killing background/PiP operations 
//     // unless the URL actually changed.
//     if (_currentUrl != url) {
//       disposeCurrentController();
//     }

//     _currentUrl = url;

//     final BetterPlayerDataSource dataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       url,


//       notificationConfiguration: BetterPlayerNotificationConfiguration(
//         showNotification: true,
//         title: title,
//         author: "Movie App",
//       ),
//       cacheConfiguration: const BetterPlayerCacheConfiguration(
//         useCache: true,
//         maxCacheSize: 1024 * 1024 * 1024, 
//         maxCacheFileSize: 100 * 1024 * 1024, 
//       ),
//     );

//     final BetterPlayerConfiguration configuration = BetterPlayerConfiguration(
//       aspectRatio: 16 / 9,
//       autoPlay: true,
//       handleLifecycle: true, 
//       autoDispose: false, 
//       // --- ENABLE PIP CONFIGURATIONS ---
//       autoDetectFullscreenDeviceOrientation: true,
//       fit: BoxFit.contain,
//       controlsConfiguration: const BetterPlayerControlsConfiguration(
//         enableSkips: true,
//         enableMute: true,
//         enableProgressText: true,
//         enablePip: true, // Enables the PiP button in the player controls
//         loadingWidget: Center(child: CircularProgressIndicator(color: Colors.red)),
//       ),
//     );

//     _currentController = BetterPlayerController(configuration, betterPlayerDataSource: dataSource);
//     return _currentController!;
//   }

//   void disposeCurrentController() {
//     _currentController?.pause(); // Explicitly pause audio before wiping memory
//     _currentController?.dispose();
//     _currentController = null;
//     _currentUrl = null;
//   }
// }

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class GlobalVideoManager {
  static final GlobalVideoManager _instance = GlobalVideoManager._internal();
  factory GlobalVideoManager() => _instance;
  GlobalVideoManager._internal();

  BetterPlayerController? _currentController;
  String? _currentUrl;

  BetterPlayerController? get currentController => _currentController;

  BetterPlayerController getOrCreateController(String url, String title) {
    if (_currentController != null && _currentUrl == url) {
      return _currentController!;
    }

    if (_currentUrl != url) {
      disposeCurrentController();
    }

    _currentUrl = url;

    final BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      // 1. TELL EXOPLAYER THIS IS AN HLS STREAM (.m3u8)
      videoFormat: BetterPlayerVideoFormat.hls,
      
      // 2. INJECT HEADERS REQUIRED BY YOUR BACKEND
      headers: const {
        'User-Agent': 'GwinBayinApp',
        'x-app-token': '47ca0305433c596d8e9990af06adcc09a967',
        'x-device-id': 'test', // Match your working postman value
        'x-app-version': '1.0.0',
        'x-real-user': 'true',
      },
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: title,
        author: "Movie App",
      ),
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 1024 * 1024 * 1024, 
        maxCacheFileSize: 100 * 1024 * 1024, 
      ),
    );

    final BetterPlayerConfiguration configuration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      autoPlay: true,
      handleLifecycle: true, 
      autoDispose: false, 
      autoDetectFullscreenDeviceOrientation: true,
      fit: BoxFit.contain,
      controlsConfiguration: const BetterPlayerControlsConfiguration(
        enableSkips: true,
        enableMute: true,
        enableProgressText: true,
        enablePip: true, 
        loadingWidget: Center(child: CircularProgressIndicator(color: Colors.red)),
      ),
    );

    _currentController = BetterPlayerController(configuration, betterPlayerDataSource: dataSource);
    return _currentController!;
  }

  void disposeCurrentController() {
    _currentController?.pause(); 
    _currentController?.dispose();
    _currentController = null;
    _currentUrl = null;
  }
}