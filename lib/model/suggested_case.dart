import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tiny_court/model/serializers.dart';

import 'enums/case_category.dart';

part 'suggested_case.g.dart';

abstract class SuggestedCase
    implements Built<SuggestedCase, SuggestedCaseBuilder> {
  SuggestedCase._();

  factory SuggestedCase([void Function(SuggestedCaseBuilder) updates]) =
      _$SuggestedCase;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(SuggestedCase.serializer, this)!
        as Map<String, dynamic>;
  }

  static SuggestedCase fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(SuggestedCase.serializer, json)!;
  }

  static Serializer<SuggestedCase> get serializer => _$suggestedCaseSerializer;

  String get id;

  String get title;

  String get description;

  CaseCategory get category;

  String get defaultPlaintiff;

  String get defaultDefendant;

  String get defaultPlaintiffArgument;

  String get defaultDefendantArgument;
}
