class AttendanceEntity {
  final int? id;
  final String? employeeId;
  final String? checkIn;
  final String? checkOut;
  final String? inMode;
  final String? outMode;
  final double? inLongitude;
  final double? inLatitude;
  final double? outLongitude;
  final double? outLatitude;
  final String? inLocation;
  final String? outLocation;
  final String? inIpAddress;
  final String? outIpAddress;

  AttendanceEntity({
    this.id,
    this.employeeId,
    this.checkIn,
    this.checkOut,
    this.inMode,
    this.outMode,
    this.inLongitude,
    this.inLatitude,
    this.outLongitude,
    this.outLatitude,
    this.inLocation,
    this.outLocation,
    this.inIpAddress,
    this.outIpAddress,
  });

  factory AttendanceEntity.fromJson(Map<String, dynamic> json) {
    return AttendanceEntity(
      id: json['id'] as int?,
      employeeId: json['employee_id'] as String?,
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
      inMode: json['in_mode'] as String?,
      outMode: json['out_mode'] as String?,
      inLongitude: json['in_longitude'] as double?,
      inLatitude: json['in_latitude'] as double?,
      outLongitude: json['out_longitude'] as double?,
      outLatitude: json['out_latitude'] as double?,
      inLocation: json['in_location'] as String?,
      outLocation: json['out_location'] as String?,
      inIpAddress: json['in_ip_address'] as String?,
      outIpAddress: json['out_ip_address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'check_in': checkIn,
      'check_out': checkOut,
      'in_mode': inMode,
      'out_mode': outMode,
      'in_longitude': inLongitude,
      'in_latitude': inLatitude,
      'out_longitude': outLongitude,
      'out_latitude': outLatitude,
      'in_location': inLocation,
      'out_location': outLocation,
      'in_ip_address': inIpAddress,
      'out_ip_address': outIpAddress,
    };
  }
}
