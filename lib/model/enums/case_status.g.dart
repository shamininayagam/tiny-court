// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CaseStatus _$draft = const CaseStatus._('draft');
const CaseStatus _$submitted = const CaseStatus._('submitted');
const CaseStatus _$decided = const CaseStatus._('decided');

CaseStatus _$valueOf(String name) {
  switch (name) {
    case 'draft':
      return _$draft;
    case 'submitted':
      return _$submitted;
    case 'decided':
      return _$decided;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CaseStatus> _$values = BuiltSet<CaseStatus>(const <CaseStatus>[
  _$draft,
  _$submitted,
  _$decided,
]);

Serializer<CaseStatus> _$caseStatusSerializer = _$CaseStatusSerializer();

class _$CaseStatusSerializer implements PrimitiveSerializer<CaseStatus> {
  @override
  final Iterable<Type> types = const <Type>[CaseStatus];
  @override
  final String wireName = 'CaseStatus';

  @override
  Object serialize(
    Serializers serializers,
    CaseStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  CaseStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CaseStatus.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
