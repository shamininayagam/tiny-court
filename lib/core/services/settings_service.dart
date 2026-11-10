import '../../model/app_settings.dart';
import 'service.dart';

/// Contract for managing application-wide settings and hardware preferences.
abstract interface class SettingsService implements Service {
  /// Returns the current in-memory cached settings.
  AppSettings getSettings();

  /// Updates sound effects preference.
  Future<void> setSoundEnabled(bool enabled);

  /// Updates haptic feedback preference.
  Future<void> setHapticsEnabled(bool enabled);

  /// Updates theme preference ('system', 'light', 'dark').
  Future<void> setThemePreference(String theme);

  /// Resets all settings to default values.
  Future<void> resetToDefaults();
}
