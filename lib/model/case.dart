import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tiny_court/model/serializers.dart';

import 'enums/case_category.dart';
import 'enums/case_status.dart';

part 'case.g.dart';

abstract class Case implements Built<Case, CaseBuilder> {


  Case._();

  factory Case([void Function(CaseBuilder) updates]) = _$Case;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Case.serializer, this)! as Map<
        String,
        dynamic>;
  }

  static Case fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Case.serializer, json)!;
  }

  static Serializer<Case> get serializer => _$caseSerializer;


  String get id;

  String get caseNumber; // TC-YYYY-XXXXX
  String get title;

  String? get description;

  CaseCategory get category;

  String get plaintiffName;

  String get plaintiffArgument;

  String get defendantName;

  String get defendantArgument;

  CaseStatus get status;

  String? get verdictId;

  String? get suggestedCaseId;

  DateTime get createdAt;

  DateTime get updatedAt;

}