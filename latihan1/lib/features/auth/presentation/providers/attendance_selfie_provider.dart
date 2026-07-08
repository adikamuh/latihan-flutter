import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/core/services/camera_service.dart';
import 'package:latihan1/features/auth/presentation/providers/auth_provider.dart';

class AttendanceSelfieProvider extends ChangeNotifier {
  final CameraService _cameraService = CameraService();

  bool _isCameraReady = false;
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isCameraReady => _isCameraReady;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  CameraController? get cameraController => _cameraService.controller;

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

  /// Mengambil foto, mendeteksi wajah, lalu mengirim ke API absensi
  Future<void> captureAndSubmitAttendance({
    required bool isCheckIn,
    required double latitude,
    required double longitude,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. Ambil foto & deteksi wajah (jika tidak ada wajah, akan throw exception)
      final File imageFile = await _cameraService.takePictureAndDetectFace();

      // 2. Kirim ke API
      final authProvider = sl<AuthProvider>();
      await authProvider.attendance(
        isCheckIn: isCheckIn,
        latitude: latitude,
        longitude: longitude,
        imageFile: imageFile,
      );
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }
}
