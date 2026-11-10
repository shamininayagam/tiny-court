import '../../core/services/settings_service.dart';
import '../../model/app_settings.dart';
import '../storage/app_storage.dart';

class SettingsServiceImpl implements SettingsService {
  final AppStorage _storage;
  late AppSettings _cachedSettings;

  SettingsServiceImpl(this._storage);

  @override
  Future<void> init() async {
    _cachedSettings = _storage.getSettings();
  }

  @override
  void dispose() {}

  @override
  AppSettings getSettings() => _cachedSettings;

  @override
  Future<void> setSoundEnabled(bool enabled) async {
    _cachedSettings = _cachedSettings.rebuild((b) => b..soundEnabled = enabled);
    await _storage.saveSettings(_cachedSettings);
  }

  @override
  Future<void> setHapticsEnabled(bool enabled) async {
    _cachedSettings = _cachedSettings.rebuild((b) => b..hapticsEnabled = enabled);
    await _storage.saveSettings(_cachedSettings);
  }

  @override
  Future<void> setThemePreference(String theme) async {
    _cachedSettings = _cachedSettings.rebuild((b) => b..themePreference = theme);
    await _storage.saveSettings(_cachedSettings);
  }

  @override
  Future<void> resetToDefaults() async {
    _cachedSettings = AppSettings.defaults;
    await _storage.saveSettings(_cachedSettings);
  }
}
