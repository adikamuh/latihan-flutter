import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:latihan1/core/services/camera_service.dart';

class AttendanceSelfieProvider extends ChangeNotifier {
  final CameraService _cameraService = CameraService();

  // --- State Kamera ---
  bool _isCameraReady = false;
  final bool _isLoading = false;
  String _errorMessage = '';

  // --- State Deteksi Wajah ---
  bool _faceDetected = false;
  late FaceDetector _faceDetector;

  // --- State Konfirmasi ---
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

  // --- PERBAIKAN: Implementasi Inisialisasi Kamera ---
  Future<void> initializeCamera() async {
    try {
      await _cameraService.initCamera();
      // Inisialisasi Face Detector
      final options = FaceDetectorOptions(
        enableLandmarks: false,
        enableClassification: false,
        enableTracking: false,
      );
      _faceDetector = FaceDetector(options: options);

      // Mulai stream gambar untuk deteksi real-time
      await _cameraService.controller!.startImageStream(_processCameraImage);
      _isCameraReady = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // --- Proses setiap frame kamera ---
  Future<void> _processCameraImage(CameraImage image) async {
    if (!_isCameraReady) return;

    try {
      // Konversi CameraImage ke InputImage (format standar ML Kit)
      final WriteBuffer buffer = WriteBuffer();
      for (final plane in image.planes) {
        buffer.putUint8List(plane.bytes);
      }
      final bytes = buffer.done().buffer.asUint8List();
      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await _faceDetector.processImage(inputImage);
      final bool newState = faces.isNotEmpty;

      if (_faceDetected != newState) {
        _faceDetected = newState;
        notifyListeners(); // Update UI saat status wajah berubah
      }
    } catch (e) {
      // Abaikan error sementara (terkadang frame pertama gagal)
    }
  }

  // --- Ambil Foto saja ---
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

  @override
  void dispose() {
    _faceDetector.close();
    _cameraService.dispose();
    super.dispose();
  }
}
