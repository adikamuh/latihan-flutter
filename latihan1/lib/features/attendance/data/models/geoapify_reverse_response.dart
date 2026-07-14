import 'package:latihan1/features/attendance/domain/entities/geoapify_reverse_entity.dart';

class GeoapifyReverseResponse {
  String? type;
  List<GeoapifyReverseEntity>? features;
  Query? query;

  GeoapifyReverseResponse({this.type, this.features, this.query});

  GeoapifyReverseResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['features'] != null) {
      features = <GeoapifyReverseEntity>[];
      json['features'].forEach((v) {
        features!.add(GeoapifyReverseEntity.fromJson(v));
      });
    }
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (query != null) {
      data['query'] = query!.toJson();
    }
    return data;
  }
}

class Query {
  double? lat;
  double? lon;
  String? plusCode;

  Query({this.lat, this.lon, this.plusCode});

  Query.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    plusCode = json['plus_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['plus_code'] = plusCode;
    return data;
  }
}
