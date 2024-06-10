import 'package:flutter/material.dart';

class ScreenTypeProvider extends ChangeNotifier {
  String featureType = ''; // Initialize featureType variable

  // Method to set the source feature type
  void setFeatureType(String type) {
    featureType = type;
    notifyListeners(); // Notify listeners of the change
  }
}
