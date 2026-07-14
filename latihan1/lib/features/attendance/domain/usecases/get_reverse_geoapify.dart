import 'package:latihan1/features/attendance/domain/entities/geoapify_reverse_entity.dart';
import 'package:latihan1/features/attendance/domain/repositories/geoapify_repository.dart';

class GetReverseGeoapify {
  final GeoapifyRepository repository;

  GetReverseGeoapify(this.repository);

  Future<GeoapifyReverseEntity?> call({
    required double lat,
    required double lon,
  }) async {
    return await repository.getReverseGeoapify(lat: lat, lon: lon);
  }
}
