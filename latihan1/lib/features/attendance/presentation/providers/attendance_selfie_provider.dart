// attendance_selfie_provider.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:latihan1/core/services/app_log.dart';
import 'package:latihan1/core/services/camera_service.dart';

class AttendanceSelfieProvider extends ChangeNotifier {
  final CameraService _cameraService = CameraService();

  bool _isCameraReady = false;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _faceDetected = false;
  FaceDetector? _faceDetector;
  File? _capturedImageFile;
  String? _timestamp;

  // --- Getter ---
  bool get isCameraReady => _isCameraReady;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;
  bool get faceDetected => _faceDetected;
  File? get capturedImageFile => _capturedImageFile;
  String? get timestamp => _timestamp;

  // --- Setter UI ---
  void setCapturedImage(File image) {
    _capturedImageFile = image;
    _timestamp = DateTime.now().toIso8601String();
    notifyListeners();
  }

  // --- Inisialisasi Kamera ---
  Future<void> initializeCamera() async {
    try {
      await _cameraService.initCamera();
      final options = FaceDetectorOptions(
        enableLandmarks: false,
        enableClassification: false,
        enableTracking: false,
      );
      _faceDetector = FaceDetector(options: options);
      await _cameraService.controller!.startImageStream(_processCameraImage);
      _isCameraReady = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // --- ✅ PERBAIKAN: Gunakan fromCameraImage ---
  // --- Proses frame menggunakan fromBytes yang sangat stabil ---
  Future<void> _processCameraImage(CameraImage image) async {
    if (!_isCameraReady || _faceDetector == null) return;

    try {
      // 1. Gabungkan semua plane (Y, U, V) ke dalam satu array bytes
      final WriteBuffer allBytes = WriteBuffer();
      for (final plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      // 2. Format standar NV21 untuk Android
      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          // Gunakan bytesPerRow dari plane ke-0 (Y)
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await _faceDetector!.processImage(inputImage);
      final bool newState = faces.isNotEmpty;

      // 3. Debugging di terminal VS Code (untuk memastikan deteksi jalan)
      AppLog.instance.logError(
        "🚨 Face detection state changed: $newState (faces: ${faces.length})",
        '',
        StackTrace.current,
      );

      if (_faceDetected != newState) {
        _faceDetected = newState;
        notifyListeners();
      }
    } catch (e, s) {
      // Abaikan error frame pertama (biasanya terjadi di awal inisialisasi)
      AppLog.instance.logError('⚠️ Frame conversion error: $e', e, s);
    }
  }

  // --- Ambil Foto ---
  Future<File> takePictureOnly() async {
    if (_cameraService.controller == null ||
        !_cameraService.controller!.value.isInitialized) {
      throw Exception('Kamera belum siap.');
    }
    final XFile xfile = await _cameraService.controller!.takePicture();
    final File file = File(xfile.path);
    setCapturedImage(file);
    return file;
  }

  // --- Reset state ---
  void resetState() {
    _capturedImageFile = null;
    _timestamp = null;
    _faceDetected = false;
    _isLoading = false;
    _errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    _faceDetector?.close();
    _cameraService.dispose();
    super.dispose();
  }
}
