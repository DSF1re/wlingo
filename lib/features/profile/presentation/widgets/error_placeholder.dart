import 'package:flutter/material.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class ErrorPlaceholder extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final AppLocalizations loc;

  const ErrorPlaceholder({
    super.key,
    required this.message,
    required this.onRetry,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          TextButton(onPressed: onRetry, child: Text(loc.retry)),
        ],
      ),
    );
  }
}
