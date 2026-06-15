import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/theme_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: SumadColors.cardDark,
              child: const Icon(Icons.person, color: Colors.white38, size: 50),
            ),
            const SizedBox(height: 16),
            const Text('User Name', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('user@email.com', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: SumadColors.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
              child: const Text('Free Plan', style: TextStyle(color: SumadColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 32),

            // Menu Items
            _menuItem(Icons.person_outline, 'Edit Profile', () => Navigator.pushNamed(context, '/edit_profile')),
            _menuItem(Icons.download_outlined, 'Downloads', () => Navigator.pushNamed(context, '/downloads')),
            _menuItem(Icons.watch_later_outlined, 'Watch History', () {}),
            _menuItem(Icons.favorite_border, 'My Favorites', () {}),
            _menuItem(Icons.bookmark_border, 'My Watchlist', () {}),
            _menuItem(Icons.star_border, 'Premium Plan', () => Navigator.pushNamed(context, '/subscription')),
            _menuItem(Icons.notifications_outlined, 'Notifications', () => Navigator.pushNamed(context, '/notifications')),
            _menuItem(Icons.language, 'Language', () => _showLanguageSheet(context)),
            _menuItem(Icons.dark_mode, 'Dark Mode', () {}),
            _menuItem(Icons.info_outline, 'About', () {}),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
              child: const Text('Sign Out', style: TextStyle(color: Colors.red, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white54, size: 24),
      title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: SumadColors.surfaceDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select Language', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
              title: const Text('English', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.check, color: SumadColors.primary),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Text('🇸🇴', style: TextStyle(fontSize: 24)),
              title: const Text('Soomaali', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
              title: const Text('العربية', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }
}