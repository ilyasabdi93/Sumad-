import 'package:flutter/material.dart';
import '../../../core/theme/theme_manager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 10,
        itemBuilder: (_, i) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: i < 2 ? SumadColors.primary.withOpacity(0.08) : SumadColors.cardDark,
            borderRadius: BorderRadius.circular(12),
            border: i < 2 ? Border.all(color: SumadColors.primary.withOpacity(0.2)) : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: SumadColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.notifications, color: SumadColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New movie added!', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: i < 2 ? FontWeight.w600 : FontWeight.w400)),
                    const SizedBox(height: 4),
                    Text('"Action Movie ${i + 1}" is now available for streaming', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                    const SizedBox(height: 6),
                    Text('${i + 1}h ago', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
                  ],
                ),
              ),
              if (i < 2)
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: SumadColors.primary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}