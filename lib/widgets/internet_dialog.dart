import 'package:flutter/material.dart';

class InternetDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const InternetDialog({required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No Internet Connection'),
      content: const Text('Please check your internet connection and try again.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close dialog on cancel
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog first
            onRetry(); // Trigger the retry callback
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
