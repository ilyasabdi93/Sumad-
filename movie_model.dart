class MovieModel {
  final String id;
  final String title;
  final String? somaliTitle;
  final String? arabicTitle;
  final String description;
  final String? somaliDescription;
  final String? arabicDescription;
  final String thumbnailUrl;
  final String? bannerUrl;
  final String? trailerUrl;
  final String? videoUrl;
  final Map<String, String> videoUrls; // quality -> url
  final List<String> categoryIds;
  final List<String> genres;
  final String? subtitleUrl;
  final List<String> subtitleUrls;
  final String duration;
  final int durationSeconds;
  final double rating;
  final int ratingCount;
  final int viewCount;
  final int downloadCount;
  final int year;
  final String? director;
  final String? cast;
  final String? ageRating;
  final bool isFeatured;
  final bool isPremium;
  final bool isPublished;
  final bool isTrending;
  final bool isSomaliContent;
  final bool isKidFriendly;
  final DateTime createdAt;
  final DateTime updatedAt;

  MovieModel({
    required this.id,
    required this.title,
    this.somaliTitle,
    this.arabicTitle,
    required this.description,
    this.somaliDescription,
    this.arabicDescription,
    required this.thumbnailUrl,
    this.bannerUrl,
    this.trailerUrl,
    this.videoUrl,
    this.videoUrls = const {},
    this.categoryIds = const [],
    this.genres = const [],
    this.subtitleUrl,
    this.subtitleUrls = const [],
    this.duration = '0 min',
    this.durationSeconds = 0,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.viewCount = 0,
    this.downloadCount = 0,
    this.year = DateTime.now().year,
    this.director,
    this.cast,
    this.ageRating,
    this.isFeatured = false,
    this.isPremium = false,
    this.isPublished = true,
    this.isTrending = false,
    this.isSomaliContent = false,
    this.isKidFriendly = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory MovieModel.fromMap(Map<String, dynamic> map, String id) {
    return MovieModel(
      id: id,
      title: map['title'] ?? '',
      somaliTitle: map['somaliTitle'],
      arabicTitle: map['arabicTitle'],
      description: map['description'] ?? '',
      somaliDescription: map['somaliDescription'],
      arabicDescription: map['arabicDescription'],
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      bannerUrl: map['bannerUrl'],
      trailerUrl: map['trailerUrl'],
      videoUrl: map['videoUrl'],
      videoUrls: Map<String, String>.from(map['videoUrls'] ?? {}),
      categoryIds: List<String>.from(map['categoryIds'] ?? []),
      genres: List<String>.from(map['genres'] ?? []),
      subtitleUrl: map['subtitleUrl'],
      subtitleUrls: List<String>.from(map['subtitleUrls'] ?? []),
      duration: map['duration'] ?? '0 min',
      durationSeconds: map['durationSeconds'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      ratingCount: map['ratingCount'] ?? 0,
      viewCount: map['viewCount'] ?? 0,
      downloadCount: map['downloadCount'] ?? 0,
      year: map['year'] ?? DateTime.now().year,
      director: map['director'],
      cast: map['cast'],
      ageRating: map['ageRating'],
      isFeatured: map['isFeatured'] ?? false,
      isPremium: map['isPremium'] ?? false,
      isPublished: map['isPublished'] ?? true,
      isTrending: map['isTrending'] ?? false,
      isSomaliContent: map['isSomaliContent'] ?? false,
      isKidFriendly: map['isKidFriendly'] ?? false,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as dynamic).toDate()
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as dynamic).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'somaliTitle': somaliTitle,
      'arabicTitle': arabicTitle,
      'description': description,
      'somaliDescription': somaliDescription,
      'arabicDescription': arabicDescription,
      'thumbnailUrl': thumbnailUrl,
      'bannerUrl': bannerUrl,
      'trailerUrl': trailerUrl,
      'videoUrl': videoUrl,
      'videoUrls': videoUrls,
      'categoryIds': categoryIds,
      'genres': genres,
      'subtitleUrl': subtitleUrl,
      'subtitleUrls': subtitleUrls,
      'duration': duration,
      'durationSeconds': durationSeconds,
      'rating': rating,
      'ratingCount': ratingCount,
      'viewCount': viewCount,
      'downloadCount': downloadCount,
      'year': year,
      'director': director,
      'cast': cast,
      'ageRating': ageRating,
      'isFeatured': isFeatured,
      'isPremium': isPremium,
      'isPublished': isPublished,
      'isTrending': isTrending,
      'isSomaliContent': isSomaliContent,
      'isKidFriendly': isKidFriendly,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}