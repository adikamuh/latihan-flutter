import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/attendance/presentation/providers/attendance_selfie_provider.dart';
import 'package:latihan1/features/attendance/presentation/views/attendance_confirm_view.dart';
import 'package:provider/provider.dart';

class AttendanceSelfieView extends StatefulWidget {
  final bool isCheckIn;
  final double latitude;
  final double longitude;
  final String locationAddress;
  final LoginEntity userData;
  final String companyName;
  final String photoUrl;

  const AttendanceSelfieView({
    super.key,
    required this.isCheckIn,
    required this.latitude,
    required this.longitude,
    required this.locationAddress,
    required this.userData,
    required this.companyName,
    required this.photoUrl,
  });

  @override
  State<AttendanceSelfieView> createState() => _AttendanceSelfieViewState();
}

class _AttendanceSelfieViewState extends State<AttendanceSelfieView> {
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleCapture(
    BuildContext context,
    AttendanceSelfieProvider provider,
  ) async {
    try {
      await provider.takePictureOnly();

      if (mounted) {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => AttendanceConfirmationView(
              userData: widget.userData,
              companyName: widget.companyName,
              photoUrl: widget.photoUrl,
              isCheckIn: widget.isCheckIn,
            ),
          ),
        );
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AttendanceSelfieProvider>(
      create: (_) => AttendanceSelfieProvider(),
      child: Consumer<AttendanceSelfieProvider>(
        builder: (context, provider, child) {
          // Inisialisasi kamera jika belum siap
          if (!provider.isCameraReady && provider.errorMessage.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                provider.initializeCamera();
              }
            });
          }

          final bool isCameraFullyReady =
              provider.cameraController != null &&
              provider.cameraController!.value.isInitialized;

          return Scaffold(
            backgroundColor: const Color(0xFF113355),
            appBar: AppBar(
              backgroundColor: const Color(0xFF113355),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Face Verification",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                // --- KAMERA PREVIEW (AMAN DARI NULL) ---
                if (provider.errorMessage.isNotEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 64,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            provider.errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("Kembali"),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (!provider.isCameraReady || !isCameraFullyReady)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                else
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.15),
                      child: AspectRatio(
                        aspectRatio:
                            provider.cameraController!.value.aspectRatio,
                        child: CameraPreview(
                          provider.cameraController!,
                          key: UniqueKey(),
                        ),
                      ),
                    ),
                  ),

                // --- OVAL OVERLAY ---
                Center(
                  child: CustomPaint(
                    painter: OvalPainter(),
                    size: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                ),

                // --- TEKS PANDUAN ---
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.45,
                  left: 0,
                  right: 0,
                  child: const Center(
                    child: Text(
                      "Position your face within the frame.",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),

                // --- FOOTER (ALAMAT & TOMBOL) ---
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Container(
                      color: const Color(0xFF113355).withValues(alpha: 0.95),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Location Detected",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.locationAddress,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: provider.isLoading
                                  ? null
                                  : () => _handleCapture(context, provider),
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFA1D645),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: provider.isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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

// OvalPainter (tidak berubah)
class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final path = Path();
    path.addOval(rect);

    final dashWidth = 8.0;
    final dashSpace = 6.0;
    final distance = path.computeMetrics().first.length;

    double currentDistance = 0;
    while (currentDistance < distance) {
      final start = currentDistance;
      final end = currentDistance + dashWidth;
      final pathSegment = path.extractPath(start, end);
      canvas.drawPath(pathSegment, paint);
      currentDistance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on Path {
  Path extractPath(double start, double end) {
    final metrics = computeMetrics();
    final path = Path();
    for (final pathMetric in metrics) {
      path.addPath(pathMetric.extractPath(start, end), Offset.zero);
    }
    return path;
  }
}
