import 'package:latihan1/core/models/app_base_response.dart';
import 'package:latihan1/features/attendance/domain/entities/attendance_entity.dart';

class AttendanceResponse extends AppBaseResponse<AttendanceEntity> {
  AttendanceResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null
          ? AttendanceEntity.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
