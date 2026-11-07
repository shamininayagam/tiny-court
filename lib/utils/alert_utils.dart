import 'package:flutter/material.dart';

import '../core/exceptions/app_exception.dart';
import 'app_logger.dart';

abstract class AlertUtils {
  Future<void> handleError(
    BuildContext context, {
    required Object error,
    StackTrace? stackTrace,
  }) async {
    await context.showError(error, stackTrace: stackTrace);
  }
}

/// Convenience extensions on [BuildContext] for localized error and feedback presentation,
/// adhering to the pogo_alarm architecture standard.
extension BuildContextErrorX on BuildContext {
  /// Canonical UI error presentation.
  ///
  /// Resolves an error message, logs diagnostic details, and displays
  /// a floating snackbar if mounted.
  Future<void> showError(
    Object error, {
    StackTrace? stackTrace,
    String? customMessage,
  }) async {
    final String message = customMessage ?? resolveErrorMessage(error);

    if (stackTrace != null) {
      AppLogger.get('BuildContextErrorX').error(
        'UI Error presented: $message',
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (!mounted) return;

    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(this);
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(this).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Displays a transient success feedback snackbar.
  void showSuccessSnack(String message) {
    if (!mounted) return;

    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(this);
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Maps any exception into a user-friendly readable message.
  String resolveErrorMessage(Object error) {
    if (error is CaseNotFoundException) {
      return error.message;
    }
    if (error is CaseAlreadyDecidedException) {
      return error.message;
    }
    if (error is CaseValidationException) {
      if (error.fieldErrors.isNotEmpty) {
        return error.fieldErrors.values.first;
      }
      return error.message;
    }
    if (error is VerdictAlreadyFinalizedException) {
      return error.message;
    }
    if (error is StorageException) {
      return 'Storage error: ${error.message}';
    }
    if (error is AppException) {
      return error.message;
    }
    return error.toString();
  }
}
