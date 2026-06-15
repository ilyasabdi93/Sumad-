import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/player/video_player_screen.dart';
import '../screens/movie/movie_detail_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/subscription/subscription_screen.dart';
import '../screens/notifications/notifications_screen.dart';
import '../screens/downloads/downloads_screen.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/admin/upload_movie_screen.dart';

class AppRouter {
  static const String home = HomeScreen.routeName;
  static const String login = LoginScreen.routeName;
  static const String register = RegisterScreen.routeName;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return _buildRoute(const SplashScreen());
      case HomeScreen.routeName:
        return _buildRoute(const HomeScreen());
      case LoginScreen.routeName:
        return _buildRoute(const LoginScreen());
      case RegisterScreen.routeName:
        return _buildRoute(const RegisterScreen());
      case '/forgot_password':
        return _buildRoute(const ForgotPasswordScreen());
      case '/movie_detail':
        return _buildRoute(MovieDetailScreen(movieData: settings.arguments as Map<String, dynamic>));
      case '/search':
        return _buildRoute(const SearchScreen());
      case '/profile':
        return _buildRoute(const ProfileScreen());
      case '/edit_profile':
        return _buildRoute(const EditProfileScreen());
      case '/subscription':
        return _buildRoute(const SubscriptionScreen());
      case '/notifications':
        return _buildRoute(const NotificationsScreen());
      case '/downloads':
        return _buildRoute(const DownloadsScreen());
      case VideoPlayerScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(VideoPlayerScreen(
          videoUrl: args['videoUrl'] as String,
          title: args['title'] as String,
          qualityUrls: args['qualityUrls'] as Map<String, String>?,
        ));
      case AdminDashboard.routeName:
        return _buildRoute(const AdminDashboard());
      case '/admin/upload_movie':
        return _buildRoute(const UploadMovieScreen());
      default:
        return _buildRoute(const HomeScreen());
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }
}