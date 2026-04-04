abstract class Failure {
  final String? message;

  const Failure({this.message});

  /// Message that can be displayed in the UI
  String get userMessage;

  bool get isDebugMode => !const bool.fromEnvironment('dart.vm.product');
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Server error'
      : 'A problem occurred. Please try again later.';

}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Cache error'
      : 'Could not access locally stored data.';
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Connection failure'
      : 'Please check your internet connection.';
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Authentication failed'
      : 'Your session has expired. Please log in again.';
}

class SynchronizationFailure extends Failure {
  const SynchronizationFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Synchronization error'
      : 'Could not synchronize. Please try again later.';
}

class DataBaseFailure extends Failure {
  const DataBaseFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Database error'
      : 'Problem accessing the database.';
}

class PermissionFailure extends Failure {
  const PermissionFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Permission denied'
      : "You don't have permission to perform this action.";
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Resource not found'
      : 'The requested information was not found.';
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Validation error'
      : 'There is invalid data in the form.';
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Timeout'
      : 'The operation took too long. Please try again.';
}

class ErrorFailure extends Failure {
  const ErrorFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Unknown error'
      : 'An unexpected error occurred. Please try again or contact support.';
}

class DataUnavailableFailure extends Failure {
  const DataUnavailableFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? 'Data unavailable'
      : 'The requested data is not available at the moment.';
}
