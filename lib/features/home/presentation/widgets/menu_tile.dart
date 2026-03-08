import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:wlingo/widgets/glass_box.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = iconColor ?? const Color(0xFF5B7BFE);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Bounceable(
        onTap: onTap,
        child: GlassBox(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          opacity: isDark ? 0.08 : 0.35,
          blur: 10,
          borderRadius: BorderRadius.circular(20),
          color: isDark ? Colors.white : Colors.white,
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withValues(
              alpha: 0.08,
            ),
            width: 1,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: color,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
