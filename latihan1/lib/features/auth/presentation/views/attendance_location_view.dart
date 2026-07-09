import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latihan1/features/auth/presentation/views/attendance_selfie_view.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';

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
  Position? _currentPosition;
  String _errorMessage = '';
  bool _isLoading = true; // Ubah final menjadi mutable
  bool _isMockLocation = false;
  String? _todayDate;
  String? _shiftInfo;

  @override
  void initState() {
    super.initState();
    _todayDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    _shiftInfo = "08:00 - 17:00 (Morning Shift)";
    // Panggil logika GPS saat layar dibuka
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      // 1. Cek dan Minta Izin GPS
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Akses GPS ditolak oleh pengguna.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage =
              'Akses GPS ditolak permanen. Mohon aktifkan di pengaturan.';
          _isLoading = false;
        });
        return;
      }

      // 2. Ambil posisi saat ini
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );

      // 3. Cek Pemalsuan Lokasi (Mock Location) khusus Android
      // (Jika di iOS, nilai .isMock akan null)
      if (position.isMocked == true) {
        setState(() {
          _isMockLocation = true;
          _errorMessage =
              'Terdeteksi pemalsuan lokasi! Tidak dapat melakukan absensi.';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal mendapatkan lokasi: $e';
        _isLoading = false;
      });
    }
  }

  // Fungsi saat tombol Check In/Out ditekan
  Future<void> _performAttendance() async {
    if (_isMockLocation || _currentPosition == null) return;

    final String locationAddress =
        "Sudirman Central Business District, Jakarta";

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceSelfieView(
          isCheckIn: widget.isCheckIn,
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
          locationAddress: locationAddress,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String clockLabel = widget.isCheckIn ? 'Check In' : 'Check Out';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- KONTEN UTAMA ---
          Column(
            children: [
              // 1. HEADER Biru Tua
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
                    Text(
                      _shiftInfo ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. KARTU PETA
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
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _errorMessage.isNotEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  _errorMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            )
                          : FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                initialCenter: LatLng(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude,
                                ),
                                initialZoom: 18.0,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.latihan1',
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      width: 40.0,
                                      height: 40.0,
                                      point: LatLng(
                                        _currentPosition!.latitude,
                                        _currentPosition!.longitude,
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

          // --- FOOTER TOMBOL ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    // Tombol Aktif (Hijau)
                    Expanded(
                      child: ElevatedButton.icon(
                        // Nonaktifkan jika error, mock location, belum dapat posisi, atau masih loading
                        onPressed:
                            (_errorMessage.isNotEmpty ||
                                _isMockLocation ||
                                _currentPosition == null ||
                                _isLoading)
                            ? null
                            : _performAttendance,
                        icon: const Icon(Icons.camera_alt_outlined, size: 20),
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
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Tombol Tidak Aktif (Abu-abu)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.camera_alt_outlined, size: 20),
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
                          padding: const EdgeInsets.symmetric(vertical: 18),
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
  }
}
