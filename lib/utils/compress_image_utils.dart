import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

import '../fs/app_file_system.dart';
import '../mixins/file_utils_mixin.dart';

class CompressImage {
  Future<AppFile?> compressImage(
    String photoId,
    File image,
  ) async {
    final Directory tempDirection = await getTemporaryDirectory();
    final String path = tempDirection.path;
    final XFile? compressedImage =
        await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImage?.toAppFile();
  }
}
