abstract class AppBaseResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final AppBaseResponseMeta? meta;

  AppBaseResponse({
    required this.success,
    required this.message,
    required this.data,
    this.meta,
  });
}

class AppBaseResponseMeta {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  AppBaseResponseMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory AppBaseResponseMeta.fromJson(Map<String, dynamic> json) {
    return AppBaseResponseMeta(
      currentPage: json['current_page'] as int?,
      lastPage: json['last_page'] as int?,
      perPage: json['per_page'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}
