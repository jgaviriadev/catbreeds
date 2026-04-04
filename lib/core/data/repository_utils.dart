import 'package:cat_breeds/core/core.dart';

Future<Result<T>> handleRepositoryCall<T>({
  required Future<T> Function() action,
  required String operation,
}) async {
  try {
    final result = await action();
    return Success(result);
  } on AppException catch (e) {
    // Map app exceptions to failures
    return Error(_mapExceptionToFailure(e));
  } catch (e, _) {
    // Handle unexpected errors (non-app exceptions)
    final String errorMessage;

    if (e is Exception) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
    } else if (e is Error) {
      errorMessage = 'Unknown error $operation: ${e.runtimeType} - $e';
    } else {
      errorMessage = 'Unknown error $operation: ${e.runtimeType} - $e';
    }

    return Error(ErrorFailure(message: errorMessage));
  }
}

/// Maps application exceptions to corresponding failures
Failure _mapExceptionToFailure(AppException exception) {
  return switch (exception) {
    ServerException() => ServerFailure(message: exception.message),
    ConnectionException() => ConnectionFailure(message: exception.message),
    CacheException() => CacheFailure(message: exception.message),
    DataBaseException() => DataBaseFailure(message: exception.message),
    UnauthorizedException() => AuthenticationFailure(message: exception.message),
    ForbiddenException() => PermissionFailure(message: exception.message),
    NotFoundException() => NotFoundFailure(message: exception.message),
    ValidationException() => ValidationFailure(message: exception.message),
    CustomTimeoutException() => TimeoutFailure(message: exception.message),
    DataUnavailableException() => DataUnavailableFailure(message: exception.message),
    UnknownException() => ErrorFailure(message: exception.message ?? 'Unknown error'),
    _ => ErrorFailure(message: exception.message ?? 'Unknown error'),
  };
}
