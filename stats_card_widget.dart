import 'package:flutter/material.dart';
import '../../../core/theme/theme_manager.dart';

class StatsCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const StatsCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SumadColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(change, style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
        ],
      ),
    );
  }
}