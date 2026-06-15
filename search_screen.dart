import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/theme_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final List<String> _trendingSearches = ['Somali Movies', 'Live TV', 'Islamic Content', 'Sports', 'Kids Shows', 'New Releases', 'Action', 'Comedy'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search movies, shows, channels...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () => setState(() => _searchController.clear()),
                        )
                      : null,
                  filled: true,
                  fillColor: SumadColors.cardDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: SumadColors.primary, width: 2),
                  ),
                ),
                onChanged: (v) => setState(() {}),
              ),
            ),
            // Content
            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildTrending()
                  : _buildResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrending() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trending Searches', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: _trendingSearches.map((s) => GestureDetector(
              onTap: () => setState(() => _searchController.text = s),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: SumadColors.cardDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(s, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: 15,
      itemBuilder: (_, i) => ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 50, height: 70,
            color: SumadColors.cardDark,
            child: const Icon(Icons.movie, color: Colors.white24, size: 24),
          ),
        ),
        title: Text('Movie Result ${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: Text('Action • 2024 • 2h 10m', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
        trailing: const Icon(Icons.play_circle_outline, color: Colors.white38, size: 24),
        onTap: () {},
      ),
    );
  }
}