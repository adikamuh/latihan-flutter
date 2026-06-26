class TenantEntity {
  final int? id;
  final String? name;
  final String? logo;

  TenantEntity({this.id, this.name, this.logo});

  factory TenantEntity.fromJson(Map<String, dynamic> json) {
    return TenantEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'logo': logo};
  }
}
