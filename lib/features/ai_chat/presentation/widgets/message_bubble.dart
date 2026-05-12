import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isDark;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: isUser
              ? MediaQuery.of(context).size.width * 0.75
              : double.infinity,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? AppColors.primaryBlue
              : (isDark ? AppColors.darkBgLighter : AppColors.lightBgDarker),
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isUser
                ? const Radius.circular(0)
                : const Radius.circular(16),
            bottomLeft: isUser
                ? const Radius.circular(16)
                : const Radius.circular(0),
          ),
        ),
        child: isUser
            ? Text(
                text,
                style: ThemeTextStyles.regular(
                  isDark: true,
                ).copyWith(color: Colors.white),
              )
            : MarkdownBody(
                data: text,
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  p: ThemeTextStyles.regular(isDark: isDark),
                  strong: ThemeTextStyles.regular(
                    isDark: isDark,
                  ).copyWith(fontWeight: FontWeight.bold),
                  tableBorder: TableBorder.all(
                    color: isDark ? Colors.white24 : Colors.black12,
                    width: 1,
                  ),
                  tableCellsPadding: const EdgeInsets.all(8),
                ),
              ),
      ),
    );
  }
}
