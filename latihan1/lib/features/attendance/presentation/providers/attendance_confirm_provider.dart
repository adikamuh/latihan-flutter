import 'package:flutter/material.dart';

class AttendanceConfirmProvider extends ChangeNotifier {
  String _notes = '';
  String get notes => _notes;

  Null get capturedImageFile => null;

  Null get currentPosition => null;

  bool? get isLoading => null;

  void setNotes(String value) {
    _notes = value;
    notifyListeners();
  }
}
