import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/config/app_config.dart';
import '../../widgets/common/app_bar_widget.dart';
import '../../widgets/home/hero_banner_widget.dart';
import '../../widgets/home/content_row_widget.dart';
import '../../widgets/home/category_row_widget.dart';
import '../../widgets/home/live_tv_row_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/home';
  
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 300 && !_showAppBar) {
      setState(() => _showAppBar = true);
    } else if (_scrollController.offset <= 300 && _showAppBar) {
      setState(() => _showAppBar = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            pinned: true,
            backgroundColor: _showAppBar
                ? SumadColors.backgroundDark
                : Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      SumadColors.backgroundDark,
                      SumadColors.backgroundDark.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            title: _showAppBar
                ? Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SumadColors.primaryGradient,
                        ),
                        child: const Center(
                          child: Text(
                            'S',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'SUMAD',
                        style: TextStyle(
                          color: SumadColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  )
                : null,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: SumadColors.textPrimary,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: SumadColors.textPrimary,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ],
          ),

          // Main Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Hero Banner
              const HeroBannerWidget(),
              const SizedBox(height: 24),

              // Quick Categories
              const CategoryRowWidget(),
              const SizedBox(height: 24),

              // Featured Movies
              ContentRowWidget(
                title: 'featured_movies'.tr(),
                subtitle: 'popular_this_week'.tr(),
                contentType: 'movies',
                filter: 'featured',
              ),
              const SizedBox(height: 24),

              // Continue Watching
              ContentRowWidget(
                title: 'continue_watching'.tr(),
                contentType: 'movies',
                filter: 'continue_watching',
              ),
              const SizedBox(height: 24),

              // Trending Now
              ContentRowWidget(
                title: 'trending_now'.tr(),
                subtitle: 'most_viewed'.tr(),
                contentType: 'movies',
                filter: 'trending',
              ),
              const SizedBox(height: 24),

              // Somali Movies
              ContentRowWidget(
                title: 'somali_movies'.tr(),
                contentType: 'movies',
                filter: 'somali',
              ),
              const SizedBox(height: 24),

              // Somali Series
              ContentRowWidget(
                title: 'somali_series'.tr(),
                contentType: 'series',
                filter: 'somali',
              ),
              const SizedBox(height: 24),

              // Popular TV Shows
              ContentRowWidget(
                title: 'tv_shows'.tr(),
                subtitle: 'top_rated'.tr(),
                contentType: 'series',
                filter: 'popular',
              ),
              const SizedBox(height: 24),

              // Live TV Channels
              const LiveTvRowWidget(),
              const SizedBox(height: 24),

              // Latest Releases
              ContentRowWidget(
                title: 'latest_releases'.tr(),
                contentType: 'movies',
                filter: 'latest',
              ),
              const SizedBox(height: 24),

              // Recommended For You
              ContentRowWidget(
                title: 'recommended_for_you'.tr(),
                contentType: 'movies',
                filter: 'recommended',
              ),
              const SizedBox(height: 24),

              // Kids Content
              ContentRowWidget(
                title: 'kids_content'.tr(),
                contentType: 'movies',
                filter: 'kids',
              ),
              const SizedBox(height: 24),

              // Islamic Content
              ContentRowWidget(
                title: 'islamic_content'.tr(),
                contentType: 'movies',
                filter: 'islamic',
              ),
              const SizedBox(height: 32),
            ]),
          ),
        ],
      ),
    );
  }
}