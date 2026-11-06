import '../../model/api_error.dart';

abstract class AppException implements Exception {}

class APIException extends AppException {
  APIException({required this.error});

  final ApiError error;

  @override
  String toString() {
    return error.message ?? 'Something went wrong';
  }
}

class GenericException extends AppException {}

class NetworkFileException extends AppException {
  @override
  String toString() {
    return 'Invalid Network File';
  }
}

class UnauthorizedException extends APIException {
  UnauthorizedException({required super.error});

  @override
  String toString() {
    return 'UnauthorizedException';
  }
}

class UnknownAuthException extends AppException {
  @override
  String toString() {
    return 'Unknown authentication exception';
  }
}

class UserNotFound extends AppException {
  @override
  String toString() {
    return 'User not found';
  }
}

class UserAlreadyExistsException extends AppException {
  @override
  String toString() {
    return 'User already exists';
  }
}

class DownloadFileException extends AppException {
  @override
  String toString() {
    return 'Error downloading the file from the url';
  }
}

class SomethingWentWrongAPI extends APIException implements SomethingWentWrong {
  SomethingWentWrongAPI({required super.error});

  @override
  String toString() {
    return 'Something went wrong';
  }
}

class SomethingWentWrong extends AppException {
  @override
  String toString() {
    return 'Something went wrong';
  }
}
