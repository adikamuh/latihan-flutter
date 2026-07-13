import 'package:dio/dio.dart';
import 'package:latihan1/core/services/env_service.dart';
import 'package:latihan1/features/attendance/data/datasources/geoapify_datasource.dart';
import 'package:latihan1/features/attendance/data/models/geoapify_reverse_response.dart';

class GeoapifyDatasourceImpl implements GeoapifyDatasource {
  final Dio _dio = Dio();

  @override
  Future<GeoapifyReverseResponse> getReverseGeoapify({
    required double lat,
    required double lon,
  }) async {
    final result = await _dio.get(
      'https://api.geoapify.com/v1/geocode/reverse',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'apiKey': EnvService.geoapifyApiKey,
      },
    );
    return GeoapifyReverseResponse.fromJson(result.data);
  }
}
