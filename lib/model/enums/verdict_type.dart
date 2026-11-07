import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verdict_type.g.dart';

/// Strongly-typed BuiltValue EnumClass representing the final judicial ruling type.
class VerdictType extends EnumClass {
  const VerdictType._(super.name);

  static const VerdictType guiltyPlaintiff = _$guiltyPlaintiff;
  static const VerdictType guiltyDefendant = _$guiltyDefendant;
  static const VerdictType bothGuilty = _$bothGuilty;
  static const VerdictType notGuilty = _$notGuilty;
  static const VerdictType caseDismissed = _$caseDismissed;
  static const VerdictType hungJury = _$hungJury;

  String get displayName => switch (this) {
        VerdictType.guiltyPlaintiff => 'Plaintiff Guilty!',
        VerdictType.guiltyDefendant => 'Defendant Guilty!',
        VerdictType.bothGuilty => 'Both Guilty!',
        VerdictType.notGuilty => 'Not Guilty!',
        VerdictType.caseDismissed => 'Case Dismissed!',
        VerdictType.hungJury => 'Hung Jury!',
        _ => name,
      };

  static BuiltSet<VerdictType> get values => _$values;
  static VerdictType valueOf(String name) => _$valueOf(name);
  static Serializer<VerdictType> get serializer => _$verdictTypeSerializer;
}
