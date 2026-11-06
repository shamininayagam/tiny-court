// native.dart

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> copyFile({
  required String filePath,
  required String copyFilePath,
}) async {
  await File(filePath).copy(copyFilePath);
}

Future<String> createFolder(String folderPath) async {
  if (!(await Directory(folderPath).exists())) {
    await Directory(folderPath).create(recursive: true);
  }
  return folderPath;
}

Future<void> deleteFolder(String folderPath) async {
  final dir = Directory(folderPath);
  if (await dir.exists()) {
    dir.deleteSync(recursive: true);
  }
}

Future<void> deleteFile(String folderPath) async {
  final file = File(folderPath);
  if (await file.exists()) {
    file.deleteSync(recursive: true);
  }
}

Future<void> renameFolder({
  required String folderPath,
  required String newName,
}) async {
  final dir = Directory(folderPath);
  if (!await dir.exists()) {
    return;
  }
  final l = folderPath.split('/');
  l.removeAt(l.length - 1);
  l.add(newName);
  final String s = l.join('/');
  await dir.rename(s);
}

Future<void> moveFile({
  required String sourceFile,
  required String newPath,
}) async {
  await createFolder(newPath);
  await File(sourceFile).copy(newPath);
  await File(sourceFile).delete();
}

Future<void> moveFolder({
  required String sourceFile,
  required String newPath,
}) async {
  await Directory(sourceFile).rename(newPath);
}

Future<void> openDirectory({
  required String filePath,
}) async {
  Uri url = Uri.parse(
    'file:$filePath',
  );
  if (!await launchUrl(
    url,
  )) {
    throw 'Cannot Open';
  }
}

Future<bool> isDirectoryPathExists(String folderPath) async {
  final dir = Directory(folderPath);
  if (await dir.exists()) {
    return true;
  }
  return false;
}

Future<bool> isFilePathExists(String filePath) async {
  final file = File(filePath);
  if (await file.exists()) {
    return true;
  }
  return false;
}
