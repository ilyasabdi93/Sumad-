class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final String? bio;
  final String subscriptionPlan;
  final DateTime? subscriptionExpiry;
  final bool isEmailVerified;
  final bool isAdmin;
  final bool isActive;
  final DateTime createdAt;
  final DateTime lastActive;
  final List<String> likedMovies;
  final List<String> ratedMovies;
  final Map<String, double> watchHistory;
  final String? fcmToken;
  final String preferenceLanguage;
  final bool darkMode;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.bio,
    this.subscriptionPlan = 'free',
    this.subscriptionExpiry,
    this.isEmailVerified = false,
    this.isAdmin = false,
    this.isActive = true,
    DateTime? createdAt,
    DateTime? lastActive,
    this.likedMovies = const [],
    this.ratedMovies = const [],
    this.watchHistory = const {},
    this.fcmToken,
    this.preferenceLanguage = 'en',
    this.darkMode = true,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastActive = lastActive ?? DateTime.now();

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      phoneNumber: map['phoneNumber'],
      bio: map['bio'],
      subscriptionPlan: map['subscriptionPlan'] ?? 'free',
      subscriptionExpiry: map['subscriptionExpiry'] != null
          ? (map['subscriptionExpiry'] as dynamic).toDate()
          : null,
      isEmailVerified: map['isEmailVerified'] ?? false,
      isAdmin: map['isAdmin'] ?? false,
      isActive: map['isActive'] ?? true,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as dynamic).toDate()
          : DateTime.now(),
      lastActive: map['lastActive'] != null
          ? (map['lastActive'] as dynamic).toDate()
          : DateTime.now(),
      likedMovies: List<String>.from(map['likedMovies'] ?? []),
      ratedMovies: List<String>.from(map['ratedMovies'] ?? []),
      watchHistory: Map<String, double>.from(map['watchHistory'] ?? {}),
      fcmToken: map['fcmToken'],
      preferenceLanguage: map['preferenceLanguage'] ?? 'en',
      darkMode: map['darkMode'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'subscriptionPlan': subscriptionPlan,
      'subscriptionExpiry': subscriptionExpiry,
      'isEmailVerified': isEmailVerified,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdAt': createdAt,
      'lastActive': lastActive,
      'likedMovies': likedMovies,
      'ratedMovies': ratedMovies,
      'watchHistory': watchHistory,
      'fcmToken': fcmToken,
      'preferenceLanguage': preferenceLanguage,
      'darkMode': darkMode,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    String? bio,
    String? subscriptionPlan,
    DateTime? subscriptionExpiry,
    bool? isEmailVerified,
    bool? isAdmin,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastActive,
    List<String>? likedMovies,
    List<String>? ratedMovies,
    Map<String, double>? watchHistory,
    String? fcmToken,
    String? preferenceLanguage,
    bool? darkMode,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isAdmin: isAdmin ?? this.isAdmin,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      likedMovies: likedMovies ?? this.likedMovies,
      ratedMovies: ratedMovies ?? this.ratedMovies,
      watchHistory: watchHistory ?? this.watchHistory,
      fcmToken: fcmToken ?? this.fcmToken,
      preferenceLanguage: preferenceLanguage ?? this.preferenceLanguage,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}