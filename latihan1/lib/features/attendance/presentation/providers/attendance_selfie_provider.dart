import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/core/services/camera_service.dart';

class AttendanceSelfieProvider extends ChangeNotifier {
  final CameraService _cameraService = CameraService();

  // --- State Kamera ---
  bool _isCameraReady = false;
  final bool _isLoading = false;
  String _errorMessage = '';

  // --- State Konfirmasi ---
  File? _capturedImageFile;
  String? _timestamp;

  // --- Getter ---
  bool get isCameraReady => _isCameraReady;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;

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
      _isCameraReady = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
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
    _cameraService.dispose();
    super.dispose();
  }
}
