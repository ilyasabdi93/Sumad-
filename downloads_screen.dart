import 'package:flutter/material.dart';
import '../../../core/theme/theme_manager.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      appBar: AppBar(title: const Text('My Downloads')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.download_outlined, color: Colors.white.withOpacity(0.2), size: 80),
            const SizedBox(height: 16),
            const Text('No downloads yet', style: TextStyle(color: Colors.white60, fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text('Download movies and shows to watch offline', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Browse Content'),
            ),
          ],
        ),
      ),
    );
  }
}