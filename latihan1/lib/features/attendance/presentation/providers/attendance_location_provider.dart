import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/features/attendance/domain/entities/geoapify_reverse_entity.dart';
import 'package:latihan1/features/attendance/domain/usecases/get_reverse_geoapify.dart';

class AttendanceLocationProvider extends ChangeNotifier {
  final GetReverseGeoapify getReverseGeoapify;

  // --- State GPS ---
  Position? _currentPosition;
  bool _isLocationLoading = false;
  String _locationError = '';
  bool _isMockLocation = false;
  String _locationAddress = '';

  AttendanceLocationProvider({required this.getReverseGeoapify});

  final List<GeoapifyReverseEntity> searchResults = [];

  Position? get currentPosition => _currentPosition;
  bool get isLocationLoading => _isLocationLoading;
  String get locationError => _locationError;
  bool get isMockLocation => _isMockLocation;
  String get locationAddress => _locationAddress;

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

      final result = await getReverseGeoapify(
        lat: _currentPosition!.latitude,
        lon: _currentPosition!.longitude,
      );
      if (result != null) {
        _locationAddress = result.properties?.formatted ?? '';
        debugPrint('[MAP] Address fetched: $_locationAddress');
      } else {
        _locationAddress = '';
        debugPrint('[MAP] No address found for the given coordinates.');
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
}
