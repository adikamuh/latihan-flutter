import 'package:dio/dio.dart';
import 'dart:convert';

import 'cache_manager.dart';

class CacheInterceptor extends Interceptor {
  final CacheManager _cacheManager;
  final Duration _defaultCacheDuration;

  CacheInterceptor({required CacheManager cacheManager})
    // ignore: prefer_initializing_formals
    : _cacheManager = cacheManager,
      _defaultCacheDuration = const Duration(minutes: 5);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip cache for non-GET requests
    if (options.method != 'GET' || options.extra['no-cache'] == true) {
      return handler.next(options);
    }

    final cacheKey = _getCacheKey(options);
    final cachedData = await _cacheManager.get<Map<String, dynamic>>(cacheKey);

    // Return cached data if available
    if (cachedData != null) {
      final Map<String, List<String>> headers = _convertMap(
        cachedData['headers'],
      );

      final response = Response(
        requestOptions: options,
        data: cachedData['data'],
        statusCode: cachedData['statusCode'],
        headers: Headers.fromMap(headers),
        extra: {'cached': true},
      );
      return handler.resolve(response);
    }

    // Check if offline and there's no cached data
    // if (!await _connectivity.isConnected) {
    //   return handler.reject(
    //     DioException(
    //       requestOptions: options,
    //       error: 'No internet connection',
    //       type: DioExceptionType.connectionError,
    //     ),
    //   );
    // }

    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Skip caching if instructed
    if (response.requestOptions.method != 'GET') {
      return handler.next(response);
    }

    // Cache the response
    final cacheKey = _getCacheKey(response.requestOptions);
    final cacheDuration =
        response.requestOptions.extra['cache-duration'] as Duration? ??
        _defaultCacheDuration;

    final cacheData = {
      'data': response.data,
      'statusCode': response.statusCode,
      'headers': response.headers.map,
    };

    await _cacheManager.set(cacheKey, cacheData, cacheDuration);
    return handler.next(response);
  }

  String _getCacheKey(RequestOptions options) {
    final uri = options.uri.toString();
    final params = options.queryParameters.isNotEmpty
        ? jsonEncode(options.queryParameters)
        : '';
    return '$uri|$params';
  }

  Map<String, List<String>> _convertMap(Map<String, dynamic> original) {
    return original.map((key, value) {
      if (value is List) {
        return MapEntry(key, value.map((e) => e.toString()).toList());
      } else {
        return MapEntry(key, [value?.toString() ?? '']);
      }
    });
  }
}
