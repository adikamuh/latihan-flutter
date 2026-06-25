import 'package:equatable/equatable.dart';

class CacheEntry extends Equatable {
  final dynamic data;
  final DateTime expiresIn;

  const CacheEntry({required this.data, required this.expiresIn});

  bool get isExpired => DateTime.now().isAfter(expiresIn);

  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry(
      data: json['data'],
      expiresIn: DateTime.fromMillisecondsSinceEpoch(json['expires_in']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'expires_in': expiresIn.millisecondsSinceEpoch};
  }

  @override
  List<Object?> get props => [data, expiresIn];
}
