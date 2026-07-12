
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

import 'global_video_manager.dart';

class VideoPlayer extends StatefulWidget {
  final String movieUrl;
  final String movieTitle;

  const VideoPlayer({
    super.key,
    required this.movieUrl,
    required this.movieTitle,
  });

  static void play(BuildContext context, String url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayer(movieUrl: url, movieTitle: title),
      ),
    );
  }

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> with WidgetsBindingObserver {
  BetterPlayerController? _controller;

  bool get _hasValidUrl => widget.movieUrl.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (_hasValidUrl) {
      _controller = GlobalVideoManager().getOrCreateController(
        widget.movieUrl,
        widget.movieTitle,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _tryEnablePictureInPicture() async {
    // Guard against invalid/empty stream URLs causing BetterPlayer layout to receive NaN.
    if (!_hasValidUrl) return;
    if (_controller == null) return;

    final isSupported = await _controller!.isPictureInPictureSupported();
    if (!isSupported) return;

    final key = _controller?.betterPlayerGlobalKey;
    if (key == null) {
      // The BetterPlayer key may be assigned after init/build. Retry once next frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final retryKey = _controller?.betterPlayerGlobalKey;
        if (retryKey != null) {
          _controller?.enablePictureInPicture(retryKey);
        }
      });
      return;
    }

    _controller?.enablePictureInPicture(key);
  }

  /// Handles App Lifecycle changes (e.g., User presses home button)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // Automatically trigger PiP if app is minimized while playing
      _tryEnablePictureInPicture();
    }
  }

  void _handleBackPress() async {

    if (_controller == null) {
      Navigator.pop(context);
      return;
    }

    // Check if the player is currently operating in Picture-in-Picture mode
    bool isPip = await _controller!.isPictureInPictureSupported();
    // isPictureInPictureActive() ?? false;

    if (!isPip) {
      // If NOT in PiP, kill the audio and controller completely on exit
      GlobalVideoManager().disposeCurrentController();
    }
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // PopScope prevents Android back gesture bypass
    return PopScope(
      canPop: false, 
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPress();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(widget.movieTitle, style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.picture_in_picture, color: Colors.white),
                onPressed: () {
                  // Programmatic button to trigger PiP mode manually
                  _tryEnablePictureInPicture();
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: _handleBackPress,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _controller == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                  : BetterPlayer(
                      key: _controller!.betterPlayerGlobalKey,
                      controller: _controller!,
                      // BetterPlayer bug workaround: hide progress bar until stream metadata is ready.
                      // Prevents NaN geometry in ProgressBarPainter for some live sources.

                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}