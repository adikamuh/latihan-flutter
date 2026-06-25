import 'package:isar_community/isar.dart';
import 'package:latihan1/features/auth/data/models/company_entity_isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static Isar? _isar;
  IsarService._privateConstructor();

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [CompanyEntityIsarSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  static Isar get isar {
    if (_isar == null) {
      throw Exception('Isar not initialized. Call IsarService.init() first.');
    }
    return _isar!;
  }
}
