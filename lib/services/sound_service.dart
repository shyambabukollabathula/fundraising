import 'package:flutter/services.dart';

class SoundService {
  static bool _soundEnabled = true;
  
  static bool get soundEnabled => _soundEnabled;
  
  static void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }
  
  static void playClickSound() {
    if (_soundEnabled) {
      HapticFeedback.lightImpact();
    }
  }
  
  static void playSuccessSound() {
    if (_soundEnabled) {
      HapticFeedback.mediumImpact();
    }
  }
  
  static void playNotificationSound() {
    if (_soundEnabled) {
      HapticFeedback.heavyImpact();
    }
  }
}
