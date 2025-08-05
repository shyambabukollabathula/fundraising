import 'package:flutter/material.dart';
import '../services/sound_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;

  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;

  ThemeData get currentTheme {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  void toggleTheme() {
    SoundService.playClickSound();
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleNotifications() {
    SoundService.playClickSound();
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    SoundService.setSoundEnabled(_soundEnabled);
    if (_soundEnabled) {
      SoundService.playSuccessSound();
    }
    notifyListeners();
  }

  static final ThemeData _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade600,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade800,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
