class AttendancePayload {
  final String type;
  final String deviceId;
  final String image;
  final double latitude;
  final double longitude;
  final String notes;
  final int employeeId;

  AttendancePayload({
    required this.type,
    required this.deviceId,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.notes,
    required this.employeeId,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'device_uuid': deviceId,
    'image': image,
    'latitude': latitude,
    'longitude': longitude,
    'notes': notes,
    'employee_id': employeeId,
  };
}
