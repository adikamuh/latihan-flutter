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

      // Gunakan resolusi LOW dan yuv420 untuk stabilitas maksimal
      _controller = CameraController(
        frontCamera,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await _controller!.initialize();

      // Inisialisasi Face Detector (hanya sekali)
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
    if (_controller == null || !_controller!.value.isInitialized) {
      throw Exception('Kamera belum siap.');
    }

    // Ambil foto
    final XFile xfile = await _controller!.takePicture();
    final File file = File(xfile.path);

    // Deteksi wajah pada foto
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
