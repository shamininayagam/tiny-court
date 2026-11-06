import '../ui.dart';

abstract class AlertUtils {
  Future<void> handleError(
    BuildContext context, {
    required Object error,
    StackTrace? stackTrace,
  }) async {
    context.scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          error.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: context.theme.colorScheme.error,
      ),
    );
  }
}
