import '../shared.dart';

mixin AppErrorUtils {
  static Future<void> handleError(
    Object error, [
    StackTrace? stackTrace,
  ]) async {
    0.log.error(error, stackTrace);
  }
}
