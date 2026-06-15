import 'package:flutter/material.dart';

class RecentUploadsWidget extends StatelessWidget {
  final String title;
  final String date;
  final String type;

  const RecentUploadsWidget({
    super.key,
    required this.title,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: type == 'Movie' ? Colors.blue.withOpacity(0.15) : Colors.orange.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              type == 'Movie' ? Icons.movie : Icons.tv,
              color: type == 'Movie' ? Colors.blue : Colors.orange,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(date, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(type, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}