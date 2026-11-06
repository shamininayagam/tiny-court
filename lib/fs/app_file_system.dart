import 'dart:typed_data';

enum AppFileSystemEntityType {
  file,
  directory,
}

abstract class AppFileSystemEntity {
  AppFileSystemEntityType get entityType;

  bool get isDirectory => entityType == AppFileSystemEntityType.directory;

  bool get isFile => entityType == AppFileSystemEntityType.file;
}

abstract class AppDirectory extends AppFileSystemEntity {
  Future<List<AppFileSystemEntity>> list();

  Future<void> delete(AppFileSystemEntity entity);

  Future<AppDirectory> rename(String name);

  Future<AppDirectory> create({bool recursive = false});

  String get path;

  String get name;

  @override
  AppFileSystemEntityType get entityType => AppFileSystemEntityType.directory;
}

abstract class AppFile extends AppFileSystemEntity {
  String get path;

  String get name;

  Future<Uint8List> readAsBytes();

  Stream<Uint8List> readStream();

  Stream<Uint8List> readStreamChunk([int? start, int? end]);

  Future<int> length();

  @override
  AppFileSystemEntityType get entityType => AppFileSystemEntityType.file;
}
