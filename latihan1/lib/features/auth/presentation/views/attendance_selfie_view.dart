import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/features/auth/presentation/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceSelfieView extends StatefulWidget {
  final bool isCheckIn;
  final double latitude;
  final double longitude;
  final String locationAddress;

  const AttendanceSelfieView({
    super.key,
    required this.isCheckIn,
    required this.latitude,
    required this.longitude,
    required this.locationAddress,
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
    AttendanceProvider provider,
  ) async {
    try {
      await provider.captureAndSubmitAttendance(
        isCheckIn: widget.isCheckIn,
        latitude: widget.latitude,
        longitude: widget.longitude,
      );

      if (mounted) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).popUntil((route) => route.isFirst);
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
    return ChangeNotifierProvider(
      create: (_) => AttendanceProvider(),
      child: Consumer<AttendanceProvider>(
        builder: (context, provider, child) {
          if (!provider.isCameraReady && provider.errorMessage.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                provider.initializeCamera();
              }
            });
          }

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
                // 1. Kamera Preview: Mengisi Seluruh Layar dengan FittedBox
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.15),
                    child: FittedBox(
                      fit: BoxFit
                          .cover, // Memastikan kamera memenuhi layar tanpa distorsi
                      child: SizedBox(
                        width:
                            provider.cameraController!.value.previewSize!.width,
                        height: provider
                            .cameraController!
                            .value
                            .previewSize!
                            .height,
                        child: CameraPreview(
                          provider.cameraController!,
                          key: UniqueKey(),
                        ),
                      ),
                    ),
                  ),
                ),

                // 2. Oval Overlay di Tengah Layar (Mengikuti Ukuran Layar, bukan kamera)
                Center(
                  child: CustomPaint(
                    painter: OvalPainter(),
                    size: Size(
                      MediaQuery.of(context).size.width *
                          0.8, // 80% lebar layar
                      MediaQuery.of(context).size.height *
                          0.4, // 40% tinggi layar
                    ),
                  ),
                ),

                // 3. Teks Panduan
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

                // 4. FOOTER (ALAMAT & TOMBOL)
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

// Oval Painter (tanpa deteksi wajah real-time)
class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Menggambar oval menggunakan ukuran size yang dikirim dari CustomPaint
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
