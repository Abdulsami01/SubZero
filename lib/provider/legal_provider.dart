import 'package:flutter/material.dart';

class LegalState with ChangeNotifier {
  String? _selectedLegalSession;
  String? _selectedLegalSessionImage;

  String? get selectedLegalSession => _selectedLegalSession;
  String? get selectedLegalSessionImage => _selectedLegalSessionImage;

  void selectLegalSession(String title, String imagePath) {
    _selectedLegalSession = title;
    _selectedLegalSessionImage = imagePath;
    notifyListeners();
  }
}
