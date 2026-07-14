import 'package:latihan1/features/attendance/data/datasources/geoapify_datasource.dart';
import 'package:latihan1/features/attendance/domain/entities/geoapify_reverse_entity.dart';
import 'package:latihan1/features/attendance/domain/repositories/geoapify_repository.dart';

class GeoapifyRepositoryImpl implements GeoapifyRepository {
  final GeoapifyDatasource _geoapifyDatasource;

  GeoapifyRepositoryImpl(this._geoapifyDatasource, Object object);

  @override
  Future<GeoapifyReverseEntity?> getReverseGeoapify({
    required double lat,
    required double lon,
  }) async {
    final result = await _geoapifyDatasource.getReverseGeoapify(
      lat: lat,
      lon: lon,
    );
    if (result.features != null && result.features!.isNotEmpty) {
      return result.features!.first;
    }
    return null;
  }
}
