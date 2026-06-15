import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/theme_manager.dart';

class ContentRowWidget extends ConsumerStatefulWidget {
  final String title;
  final String? subtitle;
  final String contentType;
  final String filter;

  const ContentRowWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.contentType,
    required this.filter,
  });

  @override
  ConsumerState<ContentRowWidget> createState() => _ContentRowWidgetState();
}

class _ContentRowWidgetState extends ConsumerState<ContentRowWidget> {
  final List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    // Mock data - will be replaced with Firestore calls
    final mockItems = List.generate(10, (index) {
      return {
        'id': 'item_$index',
        'title': 'Content Title ${index + 1}',
        'somaliTitle': 'Cinwaanka ${index + 1}',
        'thumbnailUrl': 'https://images.unsplash.com/photo-${1536440136628 + index}',
        'rating': (4.0 + (index % 10) * 0.1).toStringAsFixed(1),
        'year': 2024,
        'duration': '${120 + index} min',
        'isPremium': index % 5 == 0,
        'isNew': index < 3,
      };
    });
    setState(() => _items.addAll(mockItems));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(
                        color: SumadColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: SumadColors.primary,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _buildContentCard(_items[index], index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContentCard(Map<String, dynamic> item, int index) {
    return Animate(
      effects: [
        SlideEffect(
          begin: const Offset(0.2, 0),
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        ),
        FadeEffect(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/movie_detail', arguments: item);
        },
        child: Container(
          width: 140,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumb