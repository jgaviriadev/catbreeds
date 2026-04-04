import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

/// Service for validating internet connectivity.
///
/// Combines network connectivity checks with actual internet access validation
/// by performing DNS lookups and HTTP requests to reliable endpoints.
///
/// Use [hasInternetConnection] for one-time checks or [onConnectivityChanged]
/// for reactive monitoring of connection status changes.
class NetworkService {
  final Connectivity _connectivity = Connectivity();
  final Dio _dio;

  /// Stream that emits true/false whenever connectivity changes.
  ///
  /// Automatically validates internet access when network state changes.
  Stream<bool> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.asyncMap(
        (_) => hasInternetConnection(),
      );

  NetworkService(this._dio);

  /// Checks if device has actual internet connection.
  ///
  /// Returns true only if:
  /// 1. Device is connected to a network (WiFi/Mobile/Ethernet)
  /// 2. Internet access is verified through DNS lookup or HTTP request
  ///
  /// This method is more reliable than just checking network connectivity
  /// as it validates that traffic can reach the internet.
  Future<bool> hasInternetConnection() async {
    try {
      // 1. First verify device is connected to any network
      final connectivityResult = await _connectivity.checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return false;
      }

      // 2. Verify actual internet access
      return await _checkInternetAccess();
    } catch (e) {
      return false;
    }
  }

  /// Validates internet access through DNS lookup and HTTP requests.
  ///
  /// Attempts multiple validation methods in order:
  /// 1. DNS lookup (fastest - ~100-500ms)
  /// 2. HTTP HEAD requests to multiple endpoints (fallback)
  ///
  /// Uses multiple endpoints to ensure validation works even if one is
  /// blocked or unavailable in certain regions.
  Future<bool> _checkInternetAccess() async {
    final endpoints = [
      'https://www.google.com',
      'https://www.cloudflare.com',
      'https://1.1.1.1', // Cloudflare DNS
    ];

    // Primary method: DNS lookup (fastest and most reliable)
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      // Fallback to HTTP request
    } on TimeoutException catch (_) {
      return false;
    }

    // Fallback: Try multiple endpoints (stops at first successful)
    for (final endpoint in endpoints) {
      try {
        final response = await _dio.head<dynamic>(
          endpoint,
          options: Options(
            sendTimeout: const Duration(seconds: 3),
            receiveTimeout: const Duration(seconds: 3),
            validateStatus: (status) => status != null && status < 500,
          ),
        );

        if (response.statusCode != null && response.statusCode! < 500) {
          return true; // Stops loop on first success
        }
      } catch (_) {
        // Try next endpoint
        continue;
      }
    }

    return false;
  }

  /// Gets the current connectivity type.
  ///
  /// Returns [ConnectivityResult] indicating connection type:
  /// - wifi
  /// - mobile
  /// - ethernet
  /// - none
  Future<ConnectivityResult> getConnectivityType() async {
    final results = await _connectivity.checkConnectivity();
    return results.first;
  }

  /// Creates a stream that periodically checks internet connection.
  ///
  /// Useful for monitoring connection status at regular intervals.
  /// Default interval is 10 seconds.
  ///
  /// Example:
  /// ```dart
  /// networkService.monitorConnection(
  ///   interval: Duration(seconds: 30),
  /// ).listen((hasConnection) {
  ///   if (!hasConnection) {
  ///     showNoConnectionBanner();
  ///   }
  /// });
  /// ```
  Stream<bool> monitorConnection({
    Duration interval = const Duration(seconds: 10),
  }) {
    return Stream<void>.periodic(interval).asyncMap(
      (_) => hasInternetConnection(),
    );
  }
}
