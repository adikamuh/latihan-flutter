import 'dart:io';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/core/services/camera_service.dart';

class AttendanceProvider extends ChangeNotifier {
  final CameraService _cameraService = CameraService();

  // --- State Kamera ---
  bool _isCameraReady = false;
  bool _isLoading = false;
  String _errorMessage = '';

  // --- State GPS ---
  Position? _currentPosition;
  bool _isLocationLoading = false;
  String _locationError = '';
  bool _isMockLocation = false;

  // --- State Konfirmasi ---
  File? _capturedImageFile;
  String _notes = '';
  String? _timestamp;

  // --- Getter ---
  bool get isCameraReady => _isCameraReady;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;

  Position? get currentPosition => _currentPosition;
  bool get isLocationLoading => _isLocationLoading;
  String get locationError => _locationError;
  bool get isMockLocation => _isMockLocation;

  File? get capturedImageFile => _capturedImageFile;
  String get notes => _notes;
  String? get timestamp => _timestamp;

  // --- Setter UI ---
  void setCapturedImage(File image) {
    _capturedImageFile = image;
    _timestamp = DateTime.now().toIso8601String();
    notifyListeners();
  }

  void setNotes(String value) {
    _notes = value;
    notifyListeners();
  }

  // --- Fungsi GPS (tidak berubah) ---
  Future<Position> getLocation() async {
    _isLocationLoading = true;
    _locationError = '';
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _locationError = 'Location services are disabled.';
        throw Exception(_locationError);
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _locationError = 'Location permissions are denied';
          throw Exception(_locationError);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _locationError = 'Location permissions are permanently denied.';
        throw Exception(_locationError);
      }

      final Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentPosition = position;
      try {
        _isMockLocation = position.isMocked;
      } catch (_) {
        _isMockLocation = false;
      }

      _locationError = '';
      return position;
    } catch (e) {
      _locationError = e.toString();
      rethrow;
    } finally {
      _isLocationLoading = false;
      notifyListeners();
    }
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

  // --- PERBAIKAN: Kirim Data ke API ---
  Future<void> submitAttendance({
    required bool isCheckIn,
    required String deviceId,
    required int employeeId,
    required int userId,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_capturedImageFile == null) {
        throw Exception('No image captured.');
      }

      final bytes = await _capturedImageFile!.readAsBytes();
      base64Encode(bytes);

      // final payload = AttendancePayload(
      //   type: isCheckIn ? 'in' : 'out',
      //   latitude: _currentPosition!.latitude,
      //   longitude: _currentPosition!.longitude,
      //   notes: _notes,
      //   deviceId: deviceId,
      //   employeeId: employeeId,
      //   image: base64Image,
      // );

      // final response = await DioClient.instance.dio.post(
      //   '/api/v0.0/attendance', // Sesuaikan endpoint Anda
      //   data: payload.toJson(),
      // );

      // if (response.statusCode != 200) {
      //   throw Exception('Gagal mengirim absensi: ${response.statusCode}');
      // }

      // Update state login di AuthProvider
      // final authProvider = sl<AuthProvider>();
      // if (authProvider.loginData != null) {
      //   authProvider.loginData!.attendanceState = isCheckIn
      //       ? 'checked_in'
      //       : 'checked_out';
      //   authProvider.notifyListeners();
      // }
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
