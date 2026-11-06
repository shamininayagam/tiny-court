import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../core/exceptions/exceptions.dart';
import '../../fs/fs.dart';

extension UsageSize on double {
  String getFileSize() {
    if (this <= 0) {
      return "0 B";
    }
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(this) / log(1024)).floor();
    return '${(this / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }
}

extension AppFileUtils on AppFile {
  Future<String> getFileSize() async {
    double bytes = 0;
    bytes = (await length()).toDouble();
    if (bytes <= 0) {
      return "0 B";
    }
    return bytes.getFileSize();
  }

  bool get isDotFile => name.startsWith('.');
}

class AppIODirectory extends AppDirectory {
  AppIODirectory._(this._dir) {
    _children = _dir.listSync().map((e) {
      if (FileSystemEntity.isDirectorySync(e.path)) {
        return (e as Directory).toAppDirectory();
      }
      return (e as File).toAppFile();
    }).toList();
  }

  Directory _dir;
  late List<AppFileSystemEntity> _children;

  @override
  Future<List<AppFileSystemEntity>> list() async {
    return _children;
  }

  @override
  Future<void> delete(AppFileSystemEntity entity) async {
    _children.remove(entity);
  }

  @override
  Future<AppDirectory> rename(String name) async {
    _dir = await _dir.rename('${_dir.parent.path}/$name');
    return _dir.toAppDirectory();
  }

  @override
  Future<AppDirectory> create({bool recursive = false}) async {
    _dir = await _dir.create(recursive: recursive);
    return _dir.toAppDirectory();
  }

  @override
  String get name => basename(_dir.path);

  @override
  String get path => _dir.path;
}

class AppXFile extends AppFile {
  AppXFile._(this._file);

  final XFile _file;

  @override
  String get name => _file.name;

  @override
  String get path => _file.path;

  @override
  Future<Uint8List> readAsBytes() => _file.readAsBytes();

  @override
  Future<int> length() => _file.length();

  @override
  Stream<Uint8List> readStream() => _file.openRead();

  @override
  Stream<Uint8List> readStreamChunk([int? start, int? end]) {
    return _file.openRead(start, end);
  }
}

class AppPlatformFile extends AppFile {
  AppPlatformFile._(this._file);

  final PlatformFile _file;

  @override
  String get name => _file.name;

  // path throws error on web;
  @override
  String get path => _file.path!;

  final _chunks = <int>[];

  @override
  Future<Uint8List> readAsBytes() async {
    if (kIsWeb) {
      if (_chunks.isNotEmpty) {
        return Uint8List.fromList(_chunks);
      }
      final Completer<void> c = Completer();

      final sub = readStream().listen(
        (List<int> event) {
          _chunks.addAll(event);
        },
        onDone: () {
          c.complete();
        },
        onError: (Object e, StackTrace s) {
          c.completeError(e, s);
        },
      );

      await c.future;
      await sub.cancel();
      return Uint8List.fromList(_chunks);
    }

    return await XFile(path).readAsBytes();
  }

  @override
  Future<int> length() async => _file.size;

  @override
  Stream<Uint8List> readStream() {
    assert(_file.readStream != null);

    return _file.readStream?.map((event) {
          return event as Uint8List;
        }).asBroadcastStream() ??
        Stream<Uint8List>.fromIterable([]).asBroadcastStream();
  }

  @override
  Stream<Uint8List> readStreamChunk([int? start, int? end]) {
    throw UnimplementedError();
    // return _file.readStreamChunk
    //         ?.call(start, end)
    //         ?.map((event) => event as Uint8List) ??
    //     Stream<Uint8List>.fromIterable([]).asBroadcastStream();
  }
}

class AppNetworkFile extends AppFile {
  AppNetworkFile._(this.url);

  final String url;
  http.Response? _response;

  @override
  String get name => Uri.parse(url).path.split('/').last;

  @override
  String get path => url;

  @override
  Future<Uint8List> readAsBytes() async {
    // assert(false,
    //     'Prefer Direct download for files and Image.network for image files');
    _response ??= await http.get(Uri.parse(url));
    return _response!.bodyBytes;
  }

  @override
  Future<int> length() {
    throw UnimplementedError("Cannot get length of network file");
  }

  @override
  Stream<Uint8List> readStream() {
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> readStreamChunk([int? start, int? end]) {
    throw UnimplementedError();
  }
}

extension AppNetworkFileUtils on String {
  AppFile toAppFileFromUrl() {
    if (!startsWith('http')) {
      throw NetworkFileException();
    }

    return AppNetworkFile._(this);
  }

  AppFile toAppFileFromPath() {
    return AppXFile._(XFile(this));
  }
}

extension AppXFileUtils on XFile {
  AppFile toAppFile() => AppXFile._(this);
}

extension AppPlatformFileUtils on PlatformFile {
  AppFile toAppFile() => AppPlatformFile._(this);
}

extension AppIOFileUtils on File {
  AppFile toAppFile() {
    return XFile(path).toAppFile();
  }
}

extension AppIODirectoryUtils on Directory {
  AppDirectory toAppDirectory() {
    return AppIODirectory._(this);
  }
}

mixin FileUtils {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<AppFile?> pickImageFromCamera() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    return file?.toAppFile();
  }

  static Future<AppFile?> pickImageFromGallery() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return file?.toAppFile();
  }

  static Future<List<AppFile>?> pickMultipleImages(
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
  ) async {
    return _imagePicker
        .pickMultiImage(
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        )
        .then(
          (List<XFile> value) => value.map((XFile e) => e.toAppFile()).toList(),
        );
  }

  static Future<AppFile?> openFilePicker({
    FileType type = FileType.any,
  }) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: type, withReadStream: true);
    if (result == null || result.files.isEmpty) {
      return null;
    }
    return result.files.first.toAppFile();
  }

  static Future<List<AppFile>?> openMultiFilePicker() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      withData: false,
    );

    return result?.files.map((PlatformFile element) {
      return element.toAppFile();
    }).toList();
  }
}
