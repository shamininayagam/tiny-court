Future<bool> isDirectoryPathExists(String folderPath) async => false;

Future<bool> isFilePathExists(String filePath) async => false;

Future<void> moveFile({
  required String sourceFile,
  required String newPath,
}) async {}

Future<void> moveFolder({
  required String sourceFile,
  required String newPath,
}) async {}

Future<void> copyFile({
  required String filePath,
  required String copyFilePath,
}) async {}

Future<String> createFolder(String folderPath) async => '';

Future<String> deleteFolder(String folderPath) async => '';

Future<void> deleteFile(String folderPath) async {}

Future<void> renameFolder({
  required String folderPath,
  required String newName,
}) async {}

Future<void> openDirectory({
  required String filePath,
}) async {}
