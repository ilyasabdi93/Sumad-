import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/theme_manager.dart';

class LiveTvRowWidget extends StatelessWidget {
  const LiveTvRowWidget({super.key});

  final List<Map<String, dynamic>> _channels = const [
    {'name': 'BBC News', 'logo': 'https://img.icons8.com/color/96/bbc.png', 'category': 'News', 'live': true},
    {'name': 'Al Jazeera', 'logo': 'https://img.icons8.com/color/96/al-jazeera.png', 'category': 'News', 'live': true},
    {'name': 'Sport TV', 'logo': 'https://img.icons8.com/color/96/football2.png', 'category': 'Sports', 'live': true},
    {'name': 'Discovery', 'logo': 'https://img.icons8.com/color/96/discovery.png', 'category': 'Docs', 'live': true},
    {'name': 'Nickelodeon', 'logo': 'https://img.icons8.com/color/96/nickelodeon.png', 'category': 'Kids', 'live': true},
    {'name': 'Somali TV', 'logo': 'https://img.icons8.com/color/96/globe.png', 'category': 'Somali', 'live': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              ),
              const SizedBox(width: 8),
              const Text('Live TV', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.grid_view_rounded, size: 16),
                label: const Text('All Channels'),
                style: TextButton.styleFrom(foregroundColor: SumadColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _channels.length,
            itemBuilder: (_, i) {
              final ch = _channels[i];
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: SumadColors.cardDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.live_tv, color: SumadColors.primary, size: 22),
                    ),
                    const SizedBox(height: 8),
                    Text(ch['name'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                      child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}