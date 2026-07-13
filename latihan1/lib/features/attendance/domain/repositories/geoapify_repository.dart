import 'package:latihan1/features/attendance/domain/entities/geoapify_reverse_entity.dart';

abstract class GeoapifyRepository {
  Future<GeoapifyReverseEntity?> getReverseGeoapify({
    required double lat,
    required double lon,
  });
}
