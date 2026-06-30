class TenantPayload {
  final String code;

  TenantPayload({required this.code});

  Map<String, dynamic> toJson() => {'code': code};
}
