import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BreedErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const BreedErrorWidget({
    required this.onRetry,
    super.key,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Cat icon
                  const Center(
                    child: Icon(
                      Icons.pets,
                      size: 100,
                      color: AppColors.primary,
                    ),
                  ),
                  // Warning badge
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.warning,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Title
            Text(
              LocaleKeys.breeds_error_title.tr(),
              style: AppTextStyles.textBlackStyleBold24.copyWith(
                color: AppColors.lightText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Error message
            Text(
              errorMessage ?? LocaleKeys.breeds_error_message.tr(),
              style: AppTextStyles.textBlackStyle14.copyWith(
                color: AppColors.lightText.withValues(alpha: 0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Retry button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.breeds_retry_button.tr(),
                      style: AppTextStyles.textWhiteStyleBold,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
