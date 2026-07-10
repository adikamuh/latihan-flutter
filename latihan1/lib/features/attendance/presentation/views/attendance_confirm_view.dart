import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan1/core/services/device_info_service.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/attendance/presentation/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceConfirmationView extends StatefulWidget {
  final LoginEntity userData;
  final String companyName;
  final String photoUrl;
  final bool isCheckIn;
  final AttendanceProvider provider; // <--- WAJIB DITERIMA

  const AttendanceConfirmationView({
    super.key,
    required this.userData,
    required this.companyName,
    required this.photoUrl,
    required this.isCheckIn,
    required this.provider,
  });

  @override
  State<AttendanceConfirmationView> createState() =>
      _AttendanceConfirmationViewState();
}

class _AttendanceConfirmationViewState
    extends State<AttendanceConfirmationView> {
  Future<void> _submitAttendance(
    BuildContext context,
    AttendanceProvider provider,
  ) async {
    if (provider.capturedImageFile == null) return;

    final deviceInfo = await DeviceInfoService().getDeviceInfo();
    final String deviceId = (deviceInfo['deviceId'] as String?) ?? 'unknown';

    try {
      await provider.submitAttendance(
        isCheckIn: widget.isCheckIn,
        deviceId: deviceId,
        userId: widget.userData.uid ?? 0,
        employeeId: widget.userData.eid ?? 0,
      );

      if (mounted) {
        // ignore: use_build_context_synchronously
        _showSuccessDialog(context);
      }
    } catch (e) {
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBF9EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4CAF50),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Check-in successful.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Don't forget to check out.",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // BUNGKUS dengan ChangeNotifierProvider.value agar provider tersedia di bawahnya
    return ChangeNotifierProvider.value(
      value: widget.provider,
      child: Consumer<AttendanceProvider>(
        builder: (context, provider, child) {
          final String clockLabel = widget.isCheckIn ? 'Check In' : 'Check Out';

          return Scaffold(
            backgroundColor: const Color(0xFFF6F8F6),
            appBar: AppBar(
              backgroundColor: const Color(0xFF113355),
              elevation: 0,
              centerTitle: true,
              title: Text(
                clockLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: [
                // Header Dark Blue
                Container(
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xFF113355),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(widget.photoUrl),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userData.ename ??
                                    widget.userData.uname ??
                                    'User',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.companyName,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Monday, 24 May 2026",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const Text(
                        "08:00 - 17:00 (Morning Shift)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Card
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Foto & Info
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                    child: Image.file(
                                      provider.capturedImageFile!,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(24),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Lat : ${provider.currentPosition!.latitude}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "Long: ${provider.currentPosition!.longitude}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          DateFormat(
                                            'dd/MM/yy HH:mm',
                                          ).format(DateTime.now()),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    right: 16,
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "RETAKE PHOTO",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.refresh,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Location: ${widget.userData.getCompany()}",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Notes
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$clockLabel Notes (opsional)",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: (value) => provider.setNotes(value),
                          decoration: InputDecoration(
                            hintText: "Notes",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // Tombol bawah
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  color: const Color(0xFFF6F8F6),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed:
                          provider.isLoading ||
                              provider.capturedImageFile == null
                          ? null
                          : () => _submitAttendance(context, provider),
                      icon: provider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.camera_alt_outlined),
                      label: Text(
                        provider.isLoading
                            ? 'SENDING...'
                            : '${clockLabel.toUpperCase()} NOW',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA1D645),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
