# Preferences & Settings Specification & Contract

| Field | Value |
|---|---|
| Spec | App Settings & User Preferences Contract |
| Contract | [`SettingsService`](../../lib/core/services/settings_service.dart) |
| Model | [`AppSettings`](../../lib/model/app_settings.dart) (Built Value) |
| Reference | `pogo_alarm/app/docs/service_plans/06-preferences-device-and-config-service-contracts.md` |

---

## 1. Domain Model: `AppSettings` (`lib/model/app_settings.dart`)

```dart
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_settings.g.dart';

abstract class AppSettings implements Built<AppSettings, AppSettingsBuilder> {
  AppSettings._();
  factory AppSettings([void Function(AppSettingsBuilder) updates]) = _$AppSettings;

  bool get soundEnabled;
  bool get hapticsEnabled;
  String get themePreference; // 'system', 'light', 'dark'

  static AppSettings get defaults => AppSettings((b) => b
    ..soundEnabled = true
    ..hapticsEnabled = true
    ..themePreference = 'system');

  static Serializer<AppSettings> get serializer => _$appSettingsSerializer;
}
```

---

## 2. Core Contract: `SettingsService` (`lib/core/services/settings_service.dart`)

```dart
import '../services/service.dart';
import '../../model/app_settings.dart';

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
```
