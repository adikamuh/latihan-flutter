import 'package:latihan1/features/attendance/data/models/geoapify_reverse_response.dart';

abstract class GeoapifyDatasource {
  Future<GeoapifyReverseResponse> getReverseGeoapify({
    required double lat,
    required double lon,
  });
}
