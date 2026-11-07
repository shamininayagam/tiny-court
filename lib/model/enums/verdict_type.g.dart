// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verdict_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VerdictType _$guiltyPlaintiff = const VerdictType._('guiltyPlaintiff');
const VerdictType _$guiltyDefendant = const VerdictType._('guiltyDefendant');
const VerdictType _$bothGuilty = const VerdictType._('bothGuilty');
const VerdictType _$notGuilty = const VerdictType._('notGuilty');
const VerdictType _$caseDismissed = const VerdictType._('caseDismissed');
const VerdictType _$hungJury = const VerdictType._('hungJury');

VerdictType _$valueOf(String name) {
  switch (name) {
    case 'guiltyPlaintiff':
      return _$guiltyPlaintiff;
    case 'guiltyDefendant':
      return _$guiltyDefendant;
    case 'bothGuilty':
      return _$bothGuilty;
    case 'notGuilty':
      return _$notGuilty;
    case 'caseDismissed':
      return _$caseDismissed;
    case 'hungJury':
      return _$hungJury;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<VerdictType> _$values = BuiltSet<VerdictType>(
  const <VerdictType>[
    _$guiltyPlaintiff,
    _$guiltyDefendant,
    _$bothGuilty,
    _$notGuilty,
    _$caseDismissed,
    _$hungJury,
  ],
);

Serializer<VerdictType> _$verdictTypeSerializer = _$VerdictTypeSerializer();

class _$VerdictTypeSerializer implements PrimitiveSerializer<VerdictType> {
  @override
  final Iterable<Type> types = const <Type>[VerdictType];
  @override
  final String wireName = 'VerdictType';

  @override
  Object serialize(
    Serializers serializers,
    VerdictType object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  VerdictType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => VerdictType.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
