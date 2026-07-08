import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/custom_video_horizontal_section.dart';
import '../../../core/provider/video_notifier_provider.dart';

class HomeSliverView extends ConsumerWidget {
  final ScrollController controller;
  const HomeSliverView({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(videoProvider);

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                const HeaderProfileRow(),
                const SizedBox(height: 20),
                const FeaturedCard(),
                const SizedBox(height: 24),
                feed.when(
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      e.toString(),
                      style: const TextStyle(color: Color(0xFFE53935)),
                    ),
                  ),
                  data: (videos) {
                    return Column(
                      children: [
                        VideoHorizontalSection(
                          title: 'Trending',
                          videos: videos.take(10).toList(),
                        ),

                        // const SizedBox(height: 24),
                        // VideoHorizontalSection(
                        //   title: 'KOREA-MMSUB',
                        //   videoTitles: titles.take(10).toList(),
                        // ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }
}

class HeaderProfileRow extends StatelessWidget {
  const HeaderProfileRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(
                Icons.g_mobiledata,
                color: Colors.red,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Gwin Bayin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            'အထူးရွေးချယ်ထားသော ဗီဒီယိုများ',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.play_arrow, size: 20),
            label: const Text(
              'Play',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

