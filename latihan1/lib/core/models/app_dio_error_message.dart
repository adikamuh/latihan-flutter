import 'package:dio/dio.dart';

class AppDioErrorMessage {
  final DioException error;

  AppDioErrorMessage(this.error);

  Map<String, dynamic> toJson() {
    return {
      'success': error.response?.statusCode,
      'message': error.response?.statusMessage,
      'data': error.response?.data,
    };
  }
}
