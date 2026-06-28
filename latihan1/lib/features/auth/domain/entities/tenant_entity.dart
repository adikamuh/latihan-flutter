import 'package:latihan1/features/auth/data/models/tenant_entity_isar.dart';

class TenantEntity {
  final String? id;
  final String? name;
  final String? code;
  final String? logo;

  TenantEntity({this.id, this.name, this.code, this.logo});

  factory TenantEntity.fromJson(Map<String, dynamic> json) {
    return TenantEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      logo: json['logo'] as String?,
    );
  }

  TenantEntityIsar toIsar() {
    return TenantEntityIsar(
      id: id,
      name: name ?? '',
      code: code ?? '',
      logo: logo ?? '',
    );
  }
}
