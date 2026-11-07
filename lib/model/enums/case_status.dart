import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'case_status.g.dart';

/// Strongly-typed BuiltValue EnumClass representing the case lifecycle status.
class CaseStatus extends EnumClass {
  const CaseStatus._(super.name);

  static const CaseStatus draft = _$draft;
  static const CaseStatus submitted = _$submitted;
  static const CaseStatus decided = _$decided;

  static BuiltSet<CaseStatus> get values => _$values;
  static CaseStatus valueOf(String name) => _$valueOf(name);
  static Serializer<CaseStatus> get serializer => _$caseStatusSerializer;
}
