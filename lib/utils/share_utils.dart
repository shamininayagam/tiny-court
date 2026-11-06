import 'package:share_plus/share_plus.dart';

class ShareUtils {
  Future<void> shareText({
    required String text,
  }) async {
    await SharePlus.instance.share(
      ShareParams(text: text),
    );
  }

  Future<void> shareFiles(
    String? text, {
    required List<XFile> files,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: files,
        text: text,
      ),
    );
  }
}
