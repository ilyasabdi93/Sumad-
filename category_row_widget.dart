import 'package:flutter/material.dart';
import '../../../core/theme/theme_manager.dart';

class CategoryRowWidget extends StatelessWidget {
  const CategoryRowWidget({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'icon': Icons.movie_outlined, 'label': 'Movies', 'color': Color(0xFFE53935)},
    {'icon': Icons.tv_outlined, 'label': 'TV Shows', 'color': Color(0xFF1E88E5)},
    {'icon': Icons.live_tv_outlined, 'label': 'Live TV', 'color': Color(0xFF43A047)},
    {'icon': Icons.sports_esports_outlined, 'label': 'Sports', 'color': Color(0xFFFB8C00)},
    {'icon': Icons.article_outlined, 'label': 'News', 'color': Color(0xFF8E24AA)},
    {'icon': Icons.music_note_outlined, 'label': 'Entertainment', 'color': Color(0xFFD81B60)},
    {'icon': Icons.child_care_outlined, 'label': 'Kids', 'color': Color(0xFF00ACC1)},
    {'icon': Icons.mosque_outlined, 'label': 'Islamic', 'color': Color(0xFF6D4C41)},
    {'icon': Icons.language, 'label': 'Somali', 'color': Color(0xFF3949AB)},
    {'icon': Icons.menu_book_outlined, 'label': 'Docs', 'color': Color(0xFF546E7A)},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 72,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: (cat['color'] as Color).withOpacity(0.3)),
                    ),
                    child: Icon(cat['icon'] as IconData, color: cat['color'], size: 24),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat['label'] as String,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}