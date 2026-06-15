import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:page_transition/page_transition.dart';
import '../../../core/theme/theme_manager.dart';

class HeroBannerWidget extends ConsumerStatefulWidget {
  const HeroBannerWidget({super.key});

  @override
  ConsumerState<HeroBannerWidget> createState() => _HeroBannerWidgetState();
}

class _HeroBannerWidgetState extends ConsumerState<HeroBannerWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'New Somali Cinema',
      'subtitle': 'Experience the best of Somali storytelling',
      'image': 'https://images.unsplash.com/photo-1536440136628-849c177e76a1',
      'genre': 'Drama',
      'year': '2024',
      'rating': '8.5',
      'isNew': true,
    },
    {
      'title': 'Premium Live TV',
      'subtitle': 'Watch live channels from around the world',
      'image': 'https://images.unsplash.com/photo-1593784991095-a205069470b6',
      'genre': 'Live TV',
      'year': '24/7',
      'rating': '9.0',
      'isNew': false,
    },
    {
      'title': 'Islamic Documentaries',
      'subtitle': 'Explore faith, history, and knowledge',
      'image': 'https://images.unsplash.com/photo-1585238342024-78d387f4a707',
      'genre': 'Documentary',
      'year': '2024',
      'rating': '9.2',
      'isNew': true,
    },
    {
      'title': 'Sports & Entertainment',
      'subtitle': 'Catch all the action live',
      'image': 'https://images.unsplash.com/photo-1461896836934-bd45ba8fcf9b',
      'genre': 'Sports',
      'year': 'Live',
      'rating': '8.8',
      'isNew': false,
    },
    {
      'title': 'Kids Corner',
      'subtitle': 'Safe and fun content for children',
      'image': 'https://images.unsplash.com/photo-1518834107812-67b0b7c58434',
      'genre': 'Kids',
      'year': 'All Ages',
      'rating': '9.5',
      'isNew': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Stack(
            children: [
              // Carousel
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  autoPlayCurve: Curves.easeInOut,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() => _currentIndex = index);
                  },
                ),
                items: _banners.map((banner) {
                  return _buildBannerItem(banner);
                }).toList(),
              ),

              // Gradient Overlays
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      SumadColors.backgroundDark,
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ),
                ),
              ),

              // Side Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      SumadColors.backgroundDark,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.3],
                  ),
                ),
              ),

              // Content
              Positioned(
                left: 20,
                right: 80,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // New Tag
                    if (_banners[_currentIndex]['isNew'])
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: SumadColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'NEW RELEASE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      _banners[_currentIndex]['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      _banners[_currentIndex]['subtitle'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Meta Info
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _banners[_currentIndex]['genre'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _banners[_currentIndex]['year'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _banners[_currentIndex]['rating'],
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Action Buttons
                    Row(
                      children: [
                        // Play Button
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          decoration: BoxDecoration(
                            color: SumadColors.primary,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: SumadColors.primary.withOpacity(0.4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Play',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // My List Button
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Info Button
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Pagination Dots
              Positioned(
                right: 20,
                bottom: MediaQuery.of(context).size.height * 0.12,
                child: Column(
                  children: List.generate(
                    _banners.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? SumadColors.primary
                            : Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBannerItem(Map<String, dynamic> banner) {
    return Container(
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: banner['image'],
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: SumadColors.cardDark,
          highlightColor: SumadColors.cardLight,
          child: Container(color: SumadColors.cardDark),
        ),
        errorWidget: (context, url, error) => Container(
          color: SumadColors.cardDark,
          child: const Icon(Icons.error, color: Colors.grey),
        ),
      ),
    );
  }
}
Widget _buildContentCard(Map<String, dynamic> item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/movie_detail', arguments: item);
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Card
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://images.unsplash.com/photo-${1536440136628 + index}?w=280&h=400&fit=crop',
                    height: 200,
                    width: 140,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Shimmer.fromColors(
                      baseColor: SumadColors.cardDark,
                      highlightColor: SumadColors.cardLight,
                      child: Container(color: SumadColors.cardDark),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: SumadColors.cardDark,
                      child: const Icon(Icons.movie, color: Colors.grey),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                  // Premium Badge
                  if (item['isPremium'] == true)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: SumadColors.premium,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.black, size: 10),
                            SizedBox(width: 3),
                            Text('PREMIUM', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  // Rating
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 10),
                          const SizedBox(width: 3),
                          Text(item['rating'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  // Play button overlay
                  Positioned.fill(
                    child: AnimatedOpacity(
                      opacity: 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Title
            Text(
              item['title'],
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            // Meta
            Row(
              children: [
                Text(item['year'].toString(), style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
                const SizedBox(width: 8),
                Container(width: 3, height: 3, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.3))),
                const SizedBox(width: 8),
                Text(item['duration'], style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}