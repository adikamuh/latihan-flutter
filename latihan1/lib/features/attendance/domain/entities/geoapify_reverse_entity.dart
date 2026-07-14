class GeoapifyReverseEntity {
  String? type;
  Properties? properties;
  // Geometry? geometry;
  // List<double>? bbox;

  GeoapifyReverseEntity({this.type, this.properties});

  GeoapifyReverseEntity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    return data;
  }
}

class Properties {
  Datasource? datasource;
  String? name;
  String? country;
  String? countryCode;
  String? state;
  String? city;
  String? village;
  String? postcode;
  String? suburb;
  String? cityBlock;
  String? street;
  String? iso31662;
  String? iso31662Sublevel;
  double? lon;
  double? lat;
  num? distance;
  String? resultType;
  String? county;
  String? stateCode;
  String? countyCode;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  Timezone? timezone;
  String? plusCode;
  Rank? rank;
  String? placeId;

  Properties({
    this.datasource,
    this.name,
    this.country,
    this.countryCode,
    this.state,
    this.city,
    this.village,
    this.postcode,
    this.suburb,
    this.cityBlock,
    this.street,
    this.iso31662,
    this.iso31662Sublevel,
    this.lon,
    this.lat,
    this.distance,
    this.resultType,
    this.county,
    this.stateCode,
    this.countyCode,
    this.formatted,
    this.addressLine1,
    this.addressLine2,
    this.timezone,
    this.plusCode,
    this.rank,
    this.placeId,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    datasource = json['datasource'] != null
        ? Datasource.fromJson(json['datasource'])
        : null;
    name = json['name'];
    country = json['country'];
    countryCode = json['country_code'];
    state = json['state'];
    city = json['city'];
    village = json['village'];
    postcode = json['postcode'];
    suburb = json['suburb'];
    cityBlock = json['city_block'];
    street = json['street'];
    iso31662 = json['iso3166_2'];
    iso31662Sublevel = json['iso3166_2_sublevel'];
    lon = json['lon'];
    lat = json['lat'];
    distance = json['distance'] as num?;
    resultType = json['result_type'];
    county = json['county'];
    stateCode = json['state_code'];
    countyCode = json['county_code'];
    formatted = json['formatted'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    timezone = json['timezone'] != null
        ? Timezone.fromJson(json['timezone'])
        : null;
    plusCode = json['plus_code'];
    rank = json['rank'] != null ? Rank.fromJson(json['rank']) : null;
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (datasource != null) {
      data['datasource'] = datasource!.toJson();
    }
    data['name'] = name;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['state'] = state;
    data['city'] = city;
    data['village'] = village;
    data['postcode'] = postcode;
    data['suburb'] = suburb;
    data['city_block'] = cityBlock;
    data['street'] = street;
    data['iso3166_2'] = iso31662;
    data['iso3166_2_sublevel'] = iso31662Sublevel;
    data['lon'] = lon;
    data['lat'] = lat;
    data['distance'] = distance;
    data['result_type'] = resultType;
    data['county'] = county;
    data['state_code'] = stateCode;
    data['county_code'] = countyCode;
    data['formatted'] = formatted;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    if (timezone != null) {
      data['timezone'] = timezone!.toJson();
    }
    data['plus_code'] = plusCode;
    if (rank != null) {
      data['rank'] = rank!.toJson();
    }
    data['place_id'] = placeId;
    return data;
  }
}

class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;

  Datasource({this.sourcename, this.attribution, this.license, this.url});

  Datasource.fromJson(Map<String, dynamic> json) {
    sourcename = json['sourcename'];
    attribution = json['attribution'];
    license = json['license'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourcename'] = sourcename;
    data['attribution'] = attribution;
    data['license'] = license;
    data['url'] = url;
    return data;
  }
}

class Timezone {
  String? name;
  String? offsetSTD;
  int? offsetSTDSeconds;
  String? offsetDST;
  int? offsetDSTSeconds;
  String? abbreviationSTD;
  String? abbreviationDST;

  Timezone({
    this.name,
    this.offsetSTD,
    this.offsetSTDSeconds,
    this.offsetDST,
    this.offsetDSTSeconds,
    this.abbreviationSTD,
    this.abbreviationDST,
  });

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    offsetSTD = json['offset_STD'];
    offsetSTDSeconds = json['offset_STD_seconds'];
    offsetDST = json['offset_DST'];
    offsetDSTSeconds = json['offset_DST_seconds'];
    abbreviationSTD = json['abbreviation_STD'];
    abbreviationDST = json['abbreviation_DST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['offset_STD'] = offsetSTD;
    data['offset_STD_seconds'] = offsetSTDSeconds;
    data['offset_DST'] = offsetDST;
    data['offset_DST_seconds'] = offsetDSTSeconds;
    data['abbreviation_STD'] = abbreviationSTD;
    data['abbreviation_DST'] = abbreviationDST;
    return data;
  }
}

class Rank {
  double? importance;
  double? popularity;

  Rank({this.importance, this.popularity});

  Rank.fromJson(Map<String, dynamic> json) {
    importance = json['importance'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['importance'] = importance;
    data['popularity'] = popularity;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
