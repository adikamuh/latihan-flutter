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
  XFile? _capturedImageFile;
  String? _timestamp;

  // --- Getter ---
  bool get isCameraReady => _isCameraReady;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;
  bool get faceDetected => _faceDetected;
  XFile? get capturedImageFile => _capturedImageFile;
  String? get timestamp => _timestamp;

  // --- Setter UI ---
  void setCapturedImage(XFile image) {
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
      // await _cameraService.controller!.startImageStream(_processCameraImage);
      _isCameraReady = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // --- ✅ PERBAIKAN: Gunakan fromCameraImage ---
  // --- Proses frame menggunakan fromBytes yang sangat stabil ---
  Future<bool> _processCameraImage(XFile image) async {
    if (!_isCameraReady || _faceDetector == null) return false;

    try {
      // 1. Gabungkan semua plane (Y, U, V) ke dalam satu array bytes
      // final WriteBuffer allBytes = WriteBuffer();
      // final bytes = await image.readAsBytes();

      // 2. Format standar NV21 untuk Android
      final inputImage = InputImage.fromFilePath(image.path);
      // final inputImage = InputImage.fromBytes(
      //   bytes: bytes,
      //   metadata: InputImageMetadata(
      //     size: Size(
      //       _cameraService.controller!.value.previewSize!.width,
      //       _cameraService.controller!.value.previewSize!.height,
      //     ),
      //     rotation: InputImageRotation.rotation0deg,
      //     format: InputImageFormat.nv21,
      //     bytesPerRow: _cameraService.controller!.value.previewSize!.width
      //         .toInt(),
      //   ),
      // );

      final faces = await _faceDetector!.processImage(inputImage);
      final bool newState = faces.isNotEmpty;

      // 3. Debugging di terminal VS Code (untuk memastikan deteksi jalan)
      AppLog.instance.logError(
        "🚨 Face detection state changed: $newState (faces: ${faces.length})",
        '',
        StackTrace.current,
      );

      return faces.isNotEmpty;
    } catch (e, s) {
      // Abaikan error frame pertama (biasanya terjadi di awal inisialisasi)
      AppLog.instance.logError('⚠️ Frame conversion error: $e', e, s);
      return false;
    }
  }

  // --- Ambil Foto ---
  Future<bool> takePictureOnly() async {
    if (_cameraService.controller == null ||
        !_cameraService.controller!.value.isInitialized) {
      throw Exception('Kamera belum siap.');
    }
    final XFile xfile = await _cameraService.controller!.takePicture();
    setCapturedImage(xfile);
    final result = await _processCameraImage(xfile);
    return result;
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
