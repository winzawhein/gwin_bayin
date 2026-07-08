import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/nav_visibility_provider.dart';

/// Listens to a [ScrollController] and toggles navbar visibility.
///
/// - Scroll down => hide
/// - Scroll up => show
class ScrollNavListener extends ConsumerStatefulWidget {
  final ScrollController controller;
  final double hideOffset;

  const ScrollNavListener({
    super.key,
    required this.controller,
    this.hideOffset = 24,
  });

  @override
  ConsumerState<ScrollNavListener> createState() =>
      _ScrollNavListenerState();
}

class _ScrollNavListenerState extends ConsumerState<ScrollNavListener> {
  double _lastOffset = 0;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _lastOffset = widget.controller.hasClients ? widget.controller.offset : 0;
    widget.controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    if (!widget.controller.hasClients) return;

    final offset = widget.controller.offset;

    if (!_initialized) {
      _initialized = true;
      _lastOffset = offset;
      return;
    }

    final delta = offset - _lastOffset;
    _lastOffset = offset;

    // Ignore tiny movements to prevent flicker.
    if (delta.abs() < 4) return;

    final shouldHide = delta > 0 && offset > widget.hideOffset;
    final notifier = ref.read(navVisibleProvider.notifier);

    if (shouldHide) {
      notifier.hide();
    } else {
      notifier.show();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This widget is only a controller listener.
    return const SizedBox.shrink();
  }
}

