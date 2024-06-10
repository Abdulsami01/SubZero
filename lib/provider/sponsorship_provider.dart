import 'package:flutter/material.dart';

class SponsorshipState with ChangeNotifier {
  String? _selectedSponsorText;
  String? _selectedSponsorImage;

  String? get selectedSponsorText => _selectedSponsorText;
  String? get selectedSponsorImage => _selectedSponsorImage;

  void selectSponsorship(String title, String imagePath) {
    _selectedSponsorText = title;
    _selectedSponsorImage = imagePath;
    notifyListeners();
  }
}
