import 'package:latihan1/features/auth/data/models/company_entity_isar.dart';

class CompanyEntity {
  final String? id;
  final String? name;
  final String? code;
  final String? logoUrl;

  CompanyEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.logoUrl,
  });

  factory CompanyEntity.fromJson(Map<String, dynamic> json) {
    return CompanyEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      logoUrl: json['logoUrl'] as String?,
    );
  }

  CompanyEntityIsar toIsar() {
    return CompanyEntityIsar(
      id: id ?? '',
      name: name ?? '',
      code: code ?? '',
      logoUrl: logoUrl ?? '',
    );
  }
}
