import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/model/video_model.dart';
import 'video_player.dart';


class VideoHorizontalSection extends StatelessWidget {
  final String title;
  final List<VideoModel> videos;

  const VideoHorizontalSection({
    super.key,
    required this.title,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'View All',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(videos.length, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: VideoThumbnailCard(video: videos[index]),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class VideoThumbnailCard extends StatelessWidget {
  final VideoModel video;

  const VideoThumbnailCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final thumbnailUrl = video.thumbnail;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // log("Url>>>> ${video.url}");
        VideoPlayer.play(context, video.url, video.title);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: surfaceColor),
                    errorWidget: (context, url, error) =>
                        Container(color: surfaceColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.25),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            video.title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          const Text(
            '5.2K views • 2 days ago',
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}


