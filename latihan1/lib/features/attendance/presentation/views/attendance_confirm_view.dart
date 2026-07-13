import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan1/features/attendance/presentation/providers/attendance_confirm_provider.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:provider/provider.dart';

class AttendanceConfirmationView extends StatefulWidget {
  final LoginEntity userData;
  final String companyName;
  final String photoUrl;
  final bool isCheckIn;

  const AttendanceConfirmationView({
    super.key,
    required this.userData,
    required this.companyName,
    required this.photoUrl,
    required this.isCheckIn,
  });

  @override
  State<AttendanceConfirmationView> createState() =>
      _AttendanceConfirmationViewState();
}

class _AttendanceConfirmationViewState
    extends State<AttendanceConfirmationView> {
  @override
  Widget build(BuildContext context) {
    // BUNGKUS dengan ChangeNotifierProvider agar provider tersedia di bawahnya
    return ChangeNotifierProvider(
      create: (_) => AttendanceConfirmProvider(),
      child: Consumer<AttendanceConfirmProvider>(
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
                                    child: Container(
                                      width: double.infinity,
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.photo,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
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
                                          // ignore: dead_code
                                          "Lat : ${provider.currentPosition?.latitude ?? 'Unknown'}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          // ignore: dead_code
                                          "Long: ${provider.currentPosition?.longitude ?? 'Unknown'}",
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
                      onPressed: null,
                      icon: provider.isLoading ?? false
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
                        provider.isLoading ?? false
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
