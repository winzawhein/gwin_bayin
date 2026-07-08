import 'package:flutter/material.dart';

class DownloadsSliverView extends StatelessWidget {
  final ScrollController controller;
  const DownloadsSliverView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const goldAccent = Color(0xFFD4AF37);

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Downloads',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? goldAccent : Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download_for_offline_outlined,
                  size: 100,
                  color: isDark ? goldAccent.withOpacity(0.6) : goldAccent,
                ),
                const SizedBox(height: 32),
                Text(
                  'No Downloads Yet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Download videos to watch offline anytime',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 36),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black38 : Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: goldAccent.withOpacity(0.4),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: goldAccent,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Tap download icon on any video',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark ? goldAccent : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

