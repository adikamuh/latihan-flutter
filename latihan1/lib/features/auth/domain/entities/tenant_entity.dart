import 'package:latihan1/features/auth/data/models/tenant_entity_isar.dart';

class TenantEntity {
  final int? id;
  final String? name;
  final String? code;
  final String? logo;
  final String? address;

  TenantEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.logo,
    required this.address,
  });

  factory TenantEntity.fromJson(Map<String, dynamic> json) {
    return TenantEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      logo: json['logo'] as String?,
      address: json['address'] as String?,
    );
  }

  TenantEntityIsar toIsar() {
    return TenantEntityIsar(
      id: id,
      name: name ?? '',
      code: code ?? '',
      logo: logo ?? '',
      address: address ?? '',
    );
  }
}
