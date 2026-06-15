class AppConfig {
  static const String appName = 'SUMAD';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Watch. Stream. Enjoy.';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String moviesCollection = 'movies';
  static const String seriesCollection = 'series';
  static const String episodesCollection = 'episodes';
  static const String categoriesCollection = 'categories';
  static const String liveTvCollection = 'live_tv';
  static const String watchHistoryCollection = 'watch_history';
  static const String watchlistCollection = 'watchlist';
  static const String favoritesCollection = 'favorites';
  static const String subscriptionsCollection = 'subscriptions';
  static const String notificationsCollection = 'notifications';
  static const String reviewsCollection = 'reviews';
  static const String bannersCollection = 'banners';
  static const String analyticsCollection = 'analytics';
  static const String downloadsCollection = 'downloads';

  // Storage Paths
  static const String movieVideosPath = 'videos/movies';
  static const String episodeVideosPath = 'videos/episodes';
  static const String trailersPath = 'trailers';
  static const String thumbnailsPath = 'thumbnails';
  static const String bannersPath = 'banners';
  static const String profilePicturesPath = 'profiles';
  
  // Video Qualities
  static const List<String> videoQualities = [
    '360p',
    '480p', 
    '720p',
    '1080p',
    '4K',
  ];
  
  // Playback Speeds
  static const List<double> playbackSpeeds = [
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0,
  ];
  
  // Subscription Plans
  static const Map<String, dynamic> subscriptionPlans = {
    'free': {
      'name': 'Free',
      'price': 0,
      'quality': '480p',
      'ads': true,
      'downloads': false,
      'devices': 1,
    },
    'premium_monthly': {
      'name': 'Premium Monthly',
      'price': 9.99,
      'quality': '4K',
      'ads': false,
      'downloads': true,
      'devices': 4,
    },
    'premium_yearly': {
      'name': 'Premium Yearly',
      'price': 89.99,
      'quality': '4K',
      'ads': false,
      'downloads': true,
      'devices': 6,
    },
  };
  
  // Supported Languages
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'so', 'name': 'Soomaali', 'flag': '🇸🇴'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
  ];
  
  // Categories
  static const List<String> defaultCategories = [
    'Movies',
    'TV Shows',
    'Live TV',
    'Sports',
    'News',
    'Entertainment',
    'Kids',
    'Islamic',
    'Somali',
    'Documentaries',
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Thriller',
  ];

  // API Endpoints
  static const String apiBaseUrl = 'https://api.sumad.com/v1';
  static const String stripePublicKey = 'pk_test_your_stripe_key';
  
  // Limits
  static const int maxDownloadCount = 25;
  static const int maxWatchlistItems = 100;
  static const int maxProfilePerAccount = 5;
  static const int searchDebounceMs = 500;
  static const int pageSize = 20;
}