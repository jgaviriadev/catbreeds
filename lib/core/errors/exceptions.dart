/// Base class for all application exceptions
///
/// Provides common behavior for all custom exceptions in the app.
/// All app-specific exceptions should extend this class.
abstract class AppException implements Exception {
  final String? message;

  AppException({this.message});

  @override
  String toString() => message ?? runtimeType.toString();
}

class ServerException extends AppException {
  ServerException({super.message});
}

class CacheException extends AppException {
  CacheException({super.message});
}

class ConnectionException extends AppException {
  ConnectionException({super.message});
}

class DataBaseException extends AppException {
  DataBaseException({super.message});
}

class UnknownException extends AppException {
  UnknownException({super.message});
}

class ValidationException extends AppException {
  ValidationException({super.message});
}

class CustomTimeoutException extends AppException {
  CustomTimeoutException({super.message});
}

class NotFoundException extends AppException {
  NotFoundException({super.message});
}

class ForbiddenException extends AppException {
  ForbiddenException({super.message});
}

class UnauthorizedException extends AppException {
  UnauthorizedException({super.message});
}

class DataUnavailableException extends AppException {
  DataUnavailableException({super.message});
}
