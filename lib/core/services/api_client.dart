import 'package:cat_breeds/core/core.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Generic API client for consuming REST APIs using Dio.
///
/// Provides a unified interface for making HTTP requests with:
/// - Automatic network connectivity validation before each request
/// - Automatic error handling and exception mapping
/// - Configurable timeouts
/// - Request/response logging with Talker
/// - Support for all standard HTTP methods
class ApiClient {
  final Dio _dio;
  final Talker? talker;
  final NetworkService? networkService;

  ApiClient({
    required String baseUrl,
    this.talker,
    this.networkService,
    String? apiKey,
    Dio? dio,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 20),
    Duration sendTimeout = const Duration(seconds: 10),
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: connectTimeout,
               receiveTimeout: receiveTimeout,
               sendTimeout: sendTimeout,
               validateStatus: (_) => true,
               headers: {
                 'Accept': 'application/json',
                 'Content-Type': 'application/json',
                 if (apiKey != null && apiKey.isNotEmpty) 'x-api-key': apiKey,
               },
             ),
           ) {
    // Add Talker logger interceptor if provided
    if (talker != null) {
      _dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }
  }

  /// Access the underlying Dio instance for advanced configurations.
  Dio get dio => _dio;

  /// Extracts error message from response data.
  String? _extractErrorMessage(Response<dynamic> res) {
    final d = res.data;
    if (d is Map<String, dynamic>) {
      return d['statusMessage']?.toString() ??
          d['message']?.toString() ??
          d['error']?.toString() ??
          d['detail']?.toString();
    }
    if (d is String && d.isNotEmpty) return d;
    return null;
  }

  /// Maps HTTP status codes to custom exceptions.
  Never _throwForStatus(Response<dynamic> res) {
    final c = res.statusCode ?? 0;
    final m = _extractErrorMessage(res);

    if (c >= 200 && c < 300) {
      throw StateError('Should not call _throwForStatus on success');
    }

    switch (c) {
      case 401:
        throw UnauthorizedException(message: m ?? 'Code: $c. Unauthorized');
      case 403:
        throw ForbiddenException(message: m ?? 'Code: $c. Forbidden');
      case 404:
        throw NotFoundException(message: m ?? 'Code: $c. Not found');
      case 408:
        throw CustomTimeoutException(message: m ?? 'Code: $c. Request timeout');
      case 422:
        throw ValidationException(message: m ?? 'Code: $c. Unprocessable entity');
      default:
        if (c >= 500) {
          throw ServerException(
            message: m ?? 'Code: $c. Service not available. Contact the administrator',
          );
        }
        throw UnknownException(message: m ?? 'Code: $c. HTTP error');
    }
  }

  /// Maps Dio exceptions to custom exceptions.
  Never _mapAndThrowDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw CustomTimeoutException(message: e.message ?? 'Timeout');
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw ConnectionException(message: e.message ?? 'Network error');
      case DioExceptionType.cancel:
        throw UnknownException(message: 'Request cancelled');
      case DioExceptionType.badCertificate:
        throw ConnectionException(message: 'Bad certificate');
      case DioExceptionType.badResponse:
        final r = e.response;
        if (r != null) _throwForStatus(r);
        throw UnknownException(message: 'Bad response without status');
    }
  }

  /// Generic method for making HTTP requests.
  ///
  /// Validates internet connection before making the request.
  /// Supports GET, POST, PUT, PATCH, DELETE methods.
  /// Automatically handles errors and throws custom exceptions.
  Future<Response<T>> request<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    // Validate internet connection before making request
    if (networkService != null) {
      final hasConnection = await networkService!.hasInternetConnection();
      if (!hasConnection) {
        throw ConnectionException(
          message: 'No hay conexión a internet. Verifica tu red.',
        );
      }
    }

    try {
      final options = Options(headers: headers);
      late Response<T> res;

      switch (method.toUpperCase()) {
        case 'GET':
          res = await _dio.get<T>(
            endpoint,
            queryParameters: query,
            options: options,
          );
        case 'POST':
          res = await _dio.post<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: options,
          );
        case 'PUT':
          res = await _dio.put<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: options,
          );
        case 'PATCH':
          res = await _dio.patch<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: options,
          );
        case 'DELETE':
          res = await _dio.delete<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: options,
          );
        default:
          throw UnknownException(message: 'HTTP method $method not supported');
      }

      // Validate status code
      if ((res.statusCode ?? 0) < 200 || (res.statusCode ?? 0) >= 300) {
        _throwForStatus(res);
      }

      return res;
    } on DioException catch (e) {
      _mapAndThrowDioError(e);
    } catch (e) {
      // Rethrow app exceptions to preserve their type
      if (e is AppException) rethrow;

      // Wrap unexpected errors
      throw UnknownException(message: 'ApiClient error: $e');
    }
  }

  /// Convenience method for GET requests expecting JSON object.
  Future<Map<String, dynamic>> getJson(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final r = await request<Map<String, dynamic>>(
      method: 'GET',
      endpoint: endpoint,
      query: query,
      headers: headers,
    );
    if (r.data is Map<String, dynamic>) return r.data!;
    throw UnknownException(
      message: 'Unexpected response format (expected object)',
    );
  }

  /// Convenience method for GET requests expecting JSON array.
  Future<List<dynamic>> getList(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final r = await request<List<dynamic>>(
      method: 'GET',
      endpoint: endpoint,
      query: query,
      headers: headers,
    );
    if (r.data is List) return r.data!;
    throw UnknownException(
      message: 'Unexpected response format (expected list)',
    );
  }

  /// Convenience method for POST requests.
  Future<Response<T>> post<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    return request<T>(
      method: 'POST',
      endpoint: endpoint,
      body: body,
      query: query,
      headers: headers,
    );
  }

  /// Convenience method for PUT requests.
  Future<Response<T>> put<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    return request<T>(
      method: 'PUT',
      endpoint: endpoint,
      body: body,
      query: query,
      headers: headers,
    );
  }

  /// Convenience method for PATCH requests.
  Future<Response<T>> patch<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    return request<T>(
      method: 'PATCH',
      endpoint: endpoint,
      body: body,
      query: query,
      headers: headers,
    );
  }

  /// Convenience method for DELETE requests.
  Future<Response<T>> delete<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    return request<T>(
      method: 'DELETE',
      endpoint: endpoint,
      body: body,
      query: query,
      headers: headers,
    );
  }

  /// Convenience method for GET requests.
  Future<Response<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    return request<T>(
      method: 'GET',
      endpoint: endpoint,
      query: query,
      headers: headers,
    );
  }
}
