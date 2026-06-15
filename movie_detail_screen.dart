import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/theme_manager.dart';

class MovieDetailScreen extends StatefulWidget {
  final Map<String, dynamic> movieData;
  const MovieDetailScreen({super.key, required this.movieData});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      body: CustomScrollView(
        slivers: [
          // Hero Sliver App Bar
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: SumadColors.backgroundDark,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Shimmer.fromColors(
                      baseColor: SumadColors.cardDark,
                      highlightColor: SumadColors.cardLight,
                      child: Container(color: SumadColors.cardDark),
                    ),
                    errorWidget: (_, __, ___) => Container(color: SumadColors.cardDark, child: const Icon(Icons.movie, color: Colors.grey, size: 60)),
                  ),
                  // Dark overlays
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.transparent, SumadColors.backgroundDark],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft, end: Alignment.centerRight,
                        colors: [SumadColors.backgroundDark, Colors.transparent],
                        stops: [0.0, 0.3],
                      ),
                    ),
                  ),
                  // Bottom content on hero
                  Positioned(
                    left: 20, right: 20, bottom: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Movie Title', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            const Text('8.5', style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 16),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(border: Border.all(color: Colors.white30), borderRadius: BorderRadius.circular(4)), child: const Text('2024', style: TextStyle(color: Colors.white70, fontSize: 12))),
                            const SizedBox(width: 8),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(border: Border.all(color: Colors.white30), borderRadius: BorderRadius.circular(4)), child: const Text('2h 15m', style: TextStyle(color: Colors.white70, fontSize: 12))),
                            const SizedBox(width: 8),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(border: Border.all(color: Colors.white30), borderRadius: BorderRadius.circular(4)), child: const Text('PG-13', style: TextStyle(color: Colors.white70, fontSize: 12))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: SumadColors.primary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: SumadColors.primary.withOpacity(0.3), blurRadius: 15)],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                              SizedBox(width: 8),
                              Text('Play', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 52, width: 52,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white20), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.add, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 52, width: 52,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white20), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.download_outlined, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 52, width: 52,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white20), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.share_outlined, color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Description
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.', style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 24),
                  // Cast
                  const Text('Cast', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (_, i) => Container(
                        width: 60, margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: SumadColors.cardDark,
                              child: Text('Actor ${i + 1}'.substring(0, 2), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ),
                            const SizedBox(height: 4),
                            Text('Actor ${i + 1}', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('More Like This', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 6,
                    itemBuilder: (_, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: SumadColors.cardDark,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                color: SumadColors.cardLight,
                                child: const Center(child: Icon(Icons.movie, color: Colors.white24, size: 30)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text('Related Movie ${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}