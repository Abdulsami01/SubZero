import 'package:flutter/material.dart';

class CoachingState with ChangeNotifier {
  String? _selectedCoachingSession;
  String? _selectedCoachingSessionImage;
  String? _selectedGame;
  String? _selectedGameImage;
  String? _selectedCoach;

  String? get selectedCoachingSession => _selectedCoachingSession;
  String? get selectedCoachingSessionImage => _selectedCoachingSessionImage;
  String? get selectedGame => _selectedGame;
  String? get selectedGameImage => _selectedGameImage;
  String? get selectedCoach => _selectedCoach;

  void selectCoachingSession(String title, String imagePath) {
    _selectedCoachingSession = title;
    _selectedCoachingSessionImage = imagePath;
    notifyListeners();
  }

  void selectGame(String title, String imagePath) {
    _selectedGame = title;
    _selectedGameImage = imagePath;
    notifyListeners();
  }

  void selectCoach(String coach) {
    _selectedCoach = coach;
    notifyListeners();
  }
}
