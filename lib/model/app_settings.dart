import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_settings.g.dart';

/// Immutable domain model representing application preferences.
abstract class AppSettings implements Built<AppSettings, AppSettingsBuilder> {
  AppSettings._();
  factory AppSettings([void Function(AppSettingsBuilder) updates]) =
      _$AppSettings;

  bool get soundEnabled;
  bool get hapticsEnabled;
  String get themePreference; // 'system', 'light', 'dark'

  static AppSettings get defaults => AppSettings((b) => b
    ..soundEnabled = true
    ..hapticsEnabled = true
    ..themePreference = 'system');

  static Serializer<AppSettings> get serializer => _$appSettingsSerializer;
}
