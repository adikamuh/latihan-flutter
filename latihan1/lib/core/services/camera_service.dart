import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  FaceDetector? _faceDetector;

  Future<void> initCamera() async {
    try {
      _cameras = await availableCameras();
      final frontCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium, // Naikkan ke medium agar gambar lebih detail
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await _controller!.initialize();

      // --- TAMBAHKAN UNTUK BRIGHTNESS ---
      // Aktifkan Auto Exposure untuk menyesuaikan cahaya otomatis
      if (_controller!.value.exposureMode == ExposureMode.auto) {
        await _controller!.setExposureMode(ExposureMode.auto);
      }

      // Set Exposure Offset ke 0 (Netral) - Jika terlalu gelap, naikkan ke 0.5
      await _controller!.setExposureOffset(0.0);

      // Jika kamera mendukung fokus otomatis, aktifkan
      if (_controller!.value.focusMode == FocusMode.auto) {
        await _controller!.setFocusMode(FocusMode.auto);
      }
      // -----------------------------------------

      final options = FaceDetectorOptions(
        enableLandmarks: false,
        enableClassification: false,
        enableTracking: false,
      );
      _faceDetector = FaceDetector(options: options);
    } on PlatformException catch (e) {
      throw Exception('Kamera gagal: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil foto dan mendeteksi wajah di dalamnya
  Future<File> takePictureAndDetectFace() async {
    final XFile xfile = await _controller!.takePicture();
    final File file = File(xfile.path);
    final inputImage = InputImage.fromFilePath(file.path);
    final faces = await _faceDetector!.processImage(inputImage);
    if (faces.isEmpty) {
      throw Exception('Tidak ada wajah terdeteksi. Silakan ulangi.');
    }
    return file;
  }

  CameraController? get controller => _controller;

  void dispose() {
    _faceDetector?.close();
    _controller?.dispose();
  }
}
