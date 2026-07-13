class AttendancePayload {
  final String type;
  final String image;
  final double latitude;
  final double longitude;
  final String notes;
  final String location;
  final String ip;
  final String lastAttendanceId;

  AttendancePayload({
    required this.type,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.notes,
    required this.location,
    required this.ip,
    required this.lastAttendanceId,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'image': image,
    'latitude': latitude,
    'longitude': longitude,
    'notes': notes,
    'location': location,
    'ip': ip,
    'last_attendance_id': lastAttendanceId,
  };
}
