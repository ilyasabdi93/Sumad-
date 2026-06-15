import 'package:flutter/material.dart';
import '../../../core/theme/theme_manager.dart';

class SumadAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showLogo;

  const SumadAppBar({
    super.key,
    this.title,
    this.actions,
    this.showLogo = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: showLogo
          ? Row(
              children: [
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SumadColors.primaryGradient,
                  ),
                  child: const Center(child: Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14))),
                ),
                const SizedBox(width: 8),
                Text(title ?? 'SUMAD', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            )
          : null,
      actions: actions,
    );
  }
}