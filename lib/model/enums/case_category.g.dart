// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CaseCategory _$food = const CaseCategory._('food');
const CaseCategory _$friendship = const CaseCategory._('friendship');
const CaseCategory _$relationships = const CaseCategory._('relationships');
const CaseCategory _$work = const CaseCategory._('work');
const CaseCategory _$random = const CaseCategory._('random');

CaseCategory _$valueOf(String name) {
  switch (name) {
    case 'food':
      return _$food;
    case 'friendship':
      return _$friendship;
    case 'relationships':
      return _$relationships;
    case 'work':
      return _$work;
    case 'random':
      return _$random;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CaseCategory> _$values = BuiltSet<CaseCategory>(
  const <CaseCategory>[_$food, _$friendship, _$relationships, _$work, _$random],
);

Serializer<CaseCategory> _$caseCategorySerializer = _$CaseCategorySerializer();

class _$CaseCategorySerializer implements PrimitiveSerializer<CaseCategory> {
  @override
  final Iterable<Type> types = const <Type>[CaseCategory];
  @override
  final String wireName = 'CaseCategory';

  @override
  Object serialize(
    Serializers serializers,
    CaseCategory object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  CaseCategory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CaseCategory.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
