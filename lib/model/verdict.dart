import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tiny_court/model/serializers.dart';

import 'enums/verdict_type.dart';

part 'verdict.g.dart';

abstract class Verdict implements Built<Verdict, VerdictBuilder> {
  Verdict._();

  factory Verdict([void Function(VerdictBuilder) updates]) = _$Verdict;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Verdict.serializer, this)!
        as Map<String, dynamic>;
  }

  static Verdict fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Verdict.serializer, json)!;
  }

  static Serializer<Verdict> get serializer => _$verdictSerializer;

  String get id;

  String get caseId;

  VerdictType get verdictType;

  /// Party or parties deemed responsible (e.g. ['Alice'] or ['Alice', 'Bob'])
  BuiltList<String> get responsibleParties;

  String get judgeStatement;

  String get explanation;

  String get punishment;

  String get closingRemark;

  String get ruleId;

  DateTime get generatedAt;
}
