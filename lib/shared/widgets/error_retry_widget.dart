import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorRetryWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;
  final String? retryButtonText;

  const ErrorRetryWidget({
    required this.onRetry,
    super.key,
    this.errorMessage,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? LocaleKeys.shared_default_error_message.tr(),
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(retryButtonText ?? LocaleKeys.shared_retry_button.tr()),
          ),
        ],
      ),
    );
  }
}
