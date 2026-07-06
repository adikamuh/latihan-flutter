class LoginEntity {
  final int? uid;
  final String? uname;
  final int? eid;
  final String? ename;
  final int? pid;
  final int? currentCompany;
  final List<dynamic>? allowedCompanies;
  final String? accessToken;
  final int? expiresIn;
  final String? expiresAt;
  final int? lastAttendanceId;
  final String? lastCheckIn;
  final String? lastCheckOut;
  final String? attendanceState;
  final String? photos;

  LoginEntity({
    this.uid,
    this.uname,
    this.eid,
    this.ename,
    this.pid,
    this.currentCompany,
    this.allowedCompanies,
    this.accessToken,
    this.expiresIn,
    this.expiresAt,
    this.lastAttendanceId,
    this.lastCheckIn,
    this.lastCheckOut,
    this.attendanceState,
    this.photos,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      uid: json['uid'] as int?,
      uname: json['uname'] as String?,
      eid: json['eid'] as int?,
      ename: json['ename'] as String?,
      pid: json['pid'] as int?,
      currentCompany: json['current_company'] as int?,
      allowedCompanies: json['allowed_companies'] as List<dynamic>?,
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      expiresAt: json['expires_at'] as String?,
      lastAttendanceId: json['last_attendance_id'] as int?,
      lastCheckIn: json['last_check_in'] as String?,
      lastCheckOut: json['last_check_out'] as String?,
      attendanceState: json['attendance_state'] as String?,
      photos: json['photos'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'uname': uname,
      'eid': eid,
      'ename': ename,
      'pid': pid,
      'current_company': currentCompany,
      'allowed_companies': allowedCompanies,
      'access_token': accessToken,
      'expires_in': expiresIn,
      'expires_at': expiresAt,
      'last_attendance_id': lastAttendanceId,
      'last_check_in': lastCheckIn,
      'last_check_out': lastCheckOut,
      'attendance_state': attendanceState,
      'photos': photos,
    };
  }

  String getCompany() {
    if (currentCompany == null ||
        allowedCompanies == null ||
        allowedCompanies!.isEmpty) {
      return "-";
    } else {
      try {
        final company = allowedCompanies!.firstWhere(
          (company) => company['id'] == currentCompany,
        );
        return company != null ? company['name'] as String : "-";
      } catch (e) {
        return "-";
      }
    }
  }
}
