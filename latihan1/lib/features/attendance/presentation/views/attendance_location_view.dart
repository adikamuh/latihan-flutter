import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latlong2/latlong.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/attendance/presentation/providers/attendance_location_provider.dart';
import 'package:latihan1/features/attendance/presentation/views/attendance_selfie_view.dart';
import 'package:provider/provider.dart';

class AttendanceLocationView extends StatefulWidget {
  final LoginEntity userData;
  final String companyName;
  final String photoUrl;
  final bool isCheckIn;

  const AttendanceLocationView({
    super.key,
    required this.userData,
    required this.companyName,
    required this.photoUrl,
    required this.isCheckIn,
  });

  @override
  State<AttendanceLocationView> createState() => _AttendanceLocationViewState();
}

class _AttendanceLocationViewState extends State<AttendanceLocationView> {
  final MapController _mapController = MapController();
  final AttendanceLocationProvider _attendanceLocationProvider =
      AttendanceLocationProvider(getReverseGeoapify: sl());
  String? _todayDate;

  @override
  void initState() {
    super.initState();
    _todayDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    // Mulai ambil GPS saat halaman dibuka
    // ignore: body_might_complete_normally_catch_error
    _attendanceLocationProvider.getLocation().catchError((e) {
      // Error sudah ditangani oleh provider dan UI akan merespons
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _attendanceLocationProvider,
      child: Consumer<AttendanceLocationProvider>(
        builder: (context, provider, child) {
          final isLoading = provider.isLocationLoading;
          final errorMsg = provider.locationError;
          final isMock = provider.isMockLocation;
          final position = provider.currentPosition;

          final String clockLabel = widget.isCheckIn ? 'Check In' : 'Check Out';

          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.only(
                        top: 60,
                        left: 20,
                        right: 20,
                        bottom: 30,
                      ),
                      decoration: const BoxDecoration(color: Color(0xFF113355)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.companyName,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _todayDate ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Peta
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        child: Container(
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : errorMsg.isNotEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        errorMsg,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                : FlutterMap(
                                    mapController: _mapController,
                                    options: MapOptions(
                                      initialCenter: LatLng(
                                        position!.latitude,
                                        position.longitude,
                                      ),
                                      initialZoom: 18.0,
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        userAgentPackageName:
                                            'com.example.latihan1',
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            width: 40.0,
                                            height: 40.0,
                                            point: LatLng(
                                              position.latitude,
                                              position.longitude,
                                            ),
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),

                // Footer Tombol
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed:
                                  (errorMsg.isNotEmpty ||
                                      isMock ||
                                      position == null ||
                                      isLoading)
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AttendanceSelfieView(
                                                isCheckIn: widget.isCheckIn,
                                                latitude: position.latitude,
                                                longitude: position.longitude,
                                                locationAddress:
                                                    'Sudirman Central Business District, Jakarta', // atau dari geocoding
                                                userData: widget.userData,
                                                companyName: widget.companyName,
                                                photoUrl: widget.photoUrl,
                                              ),
                                        ),
                                      );
                                    },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                              ),
                              label: Text(
                                clockLabel.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFA1D645),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                              ),
                              label: Text(
                                widget.isCheckIn ? 'CHECK OUT' : 'CHECK IN',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
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
