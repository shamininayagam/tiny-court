// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppSettings> _$appSettingsSerializer = _$AppSettingsSerializer();

class _$AppSettingsSerializer implements StructuredSerializer<AppSettings> {
  @override
  final Iterable<Type> types = const [AppSettings, _$AppSettings];
  @override
  final String wireName = 'AppSettings';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    AppSettings object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'soundEnabled',
      serializers.serialize(
        object.soundEnabled,
        specifiedType: const FullType(bool),
      ),
      'hapticsEnabled',
      serializers.serialize(
        object.hapticsEnabled,
        specifiedType: const FullType(bool),
      ),
      'themePreference',
      serializers.serialize(
        object.themePreference,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  AppSettings deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppSettingsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'soundEnabled':
          result.soundEnabled =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'hapticsEnabled':
          result.hapticsEnabled =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'themePreference':
          result.themePreference =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AppSettings extends AppSettings {
  @override
  final bool soundEnabled;
  @override
  final bool hapticsEnabled;
  @override
  final String themePreference;

  factory _$AppSettings([void Function(AppSettingsBuilder)? updates]) =>
      (AppSettingsBuilder()..update(updates))._build();

  _$AppSettings._({
    required this.soundEnabled,
    required this.hapticsEnabled,
    required this.themePreference,
  }) : super._();
  @override
  AppSettings rebuild(void Function(AppSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppSettingsBuilder toBuilder() => AppSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppSettings &&
        soundEnabled == other.soundEnabled &&
        hapticsEnabled == other.hapticsEnabled &&
        themePreference == other.themePreference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, soundEnabled.hashCode);
    _$hash = $jc(_$hash, hapticsEnabled.hashCode);
    _$hash = $jc(_$hash, themePreference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppSettings')
          ..add('soundEnabled', soundEnabled)
          ..add('hapticsEnabled', hapticsEnabled)
          ..add('themePreference', themePreference))
        .toString();
  }
}

class AppSettingsBuilder implements Builder<AppSettings, AppSettingsBuilder> {
  _$AppSettings? _$v;

  bool? _soundEnabled;
  bool? get soundEnabled => _$this._soundEnabled;
  set soundEnabled(bool? soundEnabled) => _$this._soundEnabled = soundEnabled;

  bool? _hapticsEnabled;
  bool? get hapticsEnabled => _$this._hapticsEnabled;
  set hapticsEnabled(bool? hapticsEnabled) =>
      _$this._hapticsEnabled = hapticsEnabled;

  String? _themePreference;
  String? get themePreference => _$this._themePreference;
  set themePreference(String? themePreference) =>
      _$this._themePreference = themePreference;

  AppSettingsBuilder();

  AppSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _soundEnabled = $v.soundEnabled;
      _hapticsEnabled = $v.hapticsEnabled;
      _themePreference = $v.themePreference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppSettings other) {
    _$v = other as _$AppSettings;
  }

  @override
  void update(void Function(AppSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppSettings build() => _build();

  _$AppSettings _build() {
    final _$result =
        _$v ??
        _$AppSettings._(
          soundEnabled: BuiltValueNullFieldError.checkNotNull(
            soundEnabled,
            r'AppSettings',
            'soundEnabled',
          ),
          hapticsEnabled: BuiltValueNullFieldError.checkNotNull(
            hapticsEnabled,
            r'AppSettings',
            'hapticsEnabled',
          ),
          themePreference: BuiltValueNullFieldError.checkNotNull(
            themePreference,
            r'AppSettings',
            'themePreference',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
