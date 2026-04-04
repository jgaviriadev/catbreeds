import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Service for displaying toast notifications throughout the app.
///
/// Provides a centralized way to show success, error, warning, and info messages
/// with consistent styling and behavior.
///
/// Usage:
/// ```dart
/// sl<NotificationService>().showError('Something went wrong');
/// sl<NotificationService>().showSuccess('Operation completed');
/// ```
class NotificationService {
  /// Shows an error notification.
  ///
  /// [message] - The error message to display
  /// [title] - Optional title, defaults to 'Error'
  /// [duration] - How long to show the notification, defaults to 4 seconds
  void showError(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      type: ToastificationType.error,
      title: title ?? 'Error',
      message: message,
      duration: duration,
    );
  }

  /// Shows a success notification.
  ///
  /// [message] - The success message to display
  /// [title] - Optional title, defaults to 'Éxito'
  /// [duration] - How long to show the notification, defaults to 3 seconds
  void showSuccess(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      type: ToastificationType.success,
      title: title ?? 'Éxito',
      message: message,
      duration: duration,
    );
  }

  /// Shows a warning notification.
  ///
  /// [message] - The warning message to display
  /// [title] - Optional title, defaults to 'Advertencia'
  /// [duration] - How long to show the notification, defaults to 3 seconds
  void showWarning(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      type: ToastificationType.warning,
      title: title ?? 'Advertencia',
      message: message,
      duration: duration,
    );
  }

  /// Shows an info notification.
  ///
  /// [message] - The info message to display
  /// [title] - Optional title, defaults to 'Información'
  /// [duration] - How long to show the notification, defaults to 3 seconds
  void showInfo(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      type: ToastificationType.info,
      title: title ?? 'Información',
      message: message,
      duration: duration,
    );
  }

  /// Internal method to show the toast notification.
  void _show({
    required ToastificationType type,
    required String title,
    required String message,
    required Duration duration,
  }) {
    toastification.show(
      type: type,
      style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      description: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      autoCloseDuration: duration,
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder:
          (
            context,
            animation,
            alignment,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
      showProgressBar: true,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}
