import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';

// Auth
final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final authStateProvider = StreamProvider<User?>((ref) => ref.read(authServiceProvider).authStateChanges);

// Theme
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

// FCM Token
final fcmTokenProvider = StateProvider<String?>((ref) => null);

// User Preferences
final languageProvider = StateProvider<String>((ref) => 'en');