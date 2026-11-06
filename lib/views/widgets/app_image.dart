import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import '../../ui.dart';

class AppImage extends StatelessWidget {
  const AppImage._({
    this.imageFile,
    this.url,
    this.path,
  });

  final File? imageFile;
  final String? url;
  final String? path;

  static AppImage network(String url) {
    return AppImage._(url: url);
  }

  static AppImage asset(String path) {
    return AppImage._(path: path);
  }

  static AppImage file(File file) {
    return AppImage._(imageFile: file);
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      return Image.file(imageFile!);
    }

    if (path != null) {
      return Image.asset(path!);
    }

    if (url != null) {
      return CachedNetworkImage(
        imageUrl: url!,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return const AppProgressIndicator();
        },
      );
    }

    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('No image available'),
    );
  }
}
