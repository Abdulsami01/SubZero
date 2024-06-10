import 'package:flutter/material.dart';

class PackageState with ChangeNotifier {
  String? _selectedPackage;
  String? _selectedPackagePrice;

  String? get selectedPackage => _selectedPackage;
  String? get selectedPackagePrice => _selectedPackagePrice;

  void selectPackage(String package, String price) {
    _selectedPackage = package;
    _selectedPackagePrice = price;
    notifyListeners();
  }
}
