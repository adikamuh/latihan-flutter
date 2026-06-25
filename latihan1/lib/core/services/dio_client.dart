import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:latihan1/core/models/app_dio_error_message.dart';
import 'package:latihan1/core/services/app_log.dart';
import 'package:latihan1/core/services/env_service.dart';
import 'package:latihan1/core/services/networks/cache_interceptor.dart';
import 'package:latihan1/core/services/networks/cache_manager.dart';
import 'package:latihan1/core/services/shared_pref_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static DioClient? _instance;
  late Dio _dio;
  bool unauthorizeProcess = false;
  // Private constructor
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvService.baseUrl,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        maxWidth: 100,
        filter: (request, FilterArgs filter) {
          if (filter.isResponse &&
              (filter.data is Map<String, dynamic>) &&
              jsonEncode(filter.data).length > 5000) {
            AppLog.instance.logInfo(
              'Response data too long, truncated for logging.',
            );
            return false;
          }
          if (filter.isResponse && filter.data.toString().length > 5000) {
            AppLog.instance.logInfo(
              'Response data too long, truncated for logging.',
            );
            return false;
          }
          return true;
        },
      ),
    );
    // _dio.interceptors.add(LogarteDioInterceptor(logService.logarte));
    // _dio.transformer = AppTransformer();
    _dio.interceptors.add(
      CacheInterceptor(CacheManager(SharedPrefService.pref)),
    );
  }

  /// Call this once at app start
  static void init() {
    _instance = DioClient._internal();
  }

  /// Singleton accessor
  static DioClient get instance {
    if (_instance == null) {
      throw Exception(
        'DioClient is not initialized. Please call DioClient.init() first.',
      );
    }
    return _instance!;
  }

  /// GET request
  Future<Response> get(
    String path, {
    String? baseUrlOverride,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refreshCache = false,
  }) async {
    try {
      final url = _buildUrl(path, baseUrlOverride);
      final result = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: refreshCache
            ? options ?? Options(extra: {'no-cache': true})
            : null,
      );
      if (result.statusCode == 401) _onUnathorized();
      return result;
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) _onUnathorized();
      _throwDioError(e, s);
      rethrow;
    }
  }

  /// POST request
  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    String? baseUrlOverride,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final url = _buildUrl(path, baseUrlOverride);
      final result = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      if (result.statusCode == 401) _onUnathorized();
      return result;
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) _onUnathorized();

      _throwDioError(e, s);
      rethrow;
    }
  }

  /// POST request
  Future<Response> uploadFile(
    String path, {
    FormData? data,
    String? baseUrlOverride,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final url = _buildUrl(path, baseUrlOverride);
      final result = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      if (result.statusCode == 401) _onUnathorized();
      // final dataMap =
      //     result.data is Map ? result.data as Map<String, dynamic> : null;
      // if ((((dataMap?['code'] as int?) ?? 911) > 299) ||
      //     ((dataMap?['code'] as int?) ?? 911) < 200) {
      //   _throwDioError(
      //     DioException(requestOptions: result.requestOptions, response: result),
      //     StackTrace.current,
      //   );
      // }
      return result;
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) _onUnathorized();

      _throwDioError(e, s);
      rethrow;
    }
  }

  Future<Response> downloadFile(
    String path,
    String savePath, {
    String? baseUrlOverride,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final url = _buildUrl(path, baseUrlOverride);
      final result = await _dio.download(
        url,
        savePath,
        options: options,
        queryParameters: queryParameters,
      );
      if (result.statusCode == 401) _onUnathorized();
      return result;
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) _onUnathorized();

      _throwDioError(e, s);
      rethrow;
    }
  }

  void _throwDioError(DioException e, StackTrace s) {
    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response?.data as Map<String, dynamic>;
      throw DioException(
        requestOptions: e.requestOptions,
        message: jsonEncode(AppDioErrorMessage(e).toJson()),
        response: Response(requestOptions: e.requestOptions, data: data),
        type: e.type,
        error: e.error,
        stackTrace: s,
      );
    } else {
      throw DioException(
        requestOptions: e.requestOptions,
        message: jsonEncode(AppDioErrorMessage(e).toJson()),
        response: Response(
          requestOptions: e.requestOptions,
          data: {
            "message":
                "Terjadi kesalahan. Error code: ${e.response?.statusCode}",
            "response": e.response?.data,
          },
        ),
        type: e.type,
        error: e.error,
        stackTrace: s,
      );
    }
  }

  void updateHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  void setToken(String token) {
    if (token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  dynamic getToken() {
    return _dio.options.headers['Authorization'];
  }

  /// Helper to combine baseUrl and path
  String _buildUrl(String path, String? override) {
    if (override != null && override.isNotEmpty) {
      return Uri.parse(override).resolve(path).toString();
    }
    return path; // Assumes path is a full URL or uses Dio's baseUrl
  }

  void _onUnathorized() {
    // final authController = g.Get.find<AuthController>();
    // if (!unauthorizeProcess && authController.loggedIn.value == true) {
    //   unauthorizeProcess = true;
    //   authController.logout(isUnauthorized: true);
    //   SnackbarHelper.showError('Sesi telah berakhir, silakan login kembali');
    //   Future.delayed(const Duration(seconds: 2), () {
    //     unauthorizeProcess = false;
    //   });
    // }
  }
}
