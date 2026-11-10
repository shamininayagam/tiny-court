import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../enums/case_category.dart';
import '../serializers.dart';

part 'case_draft_state.g.dart';

/// Strongly-typed wizard step enum
class DraftStep extends EnumClass {
  const DraftStep._(super.name);

  static const DraftStep overview = _$overview;
  static const DraftStep plaintiff = _$plaintiff;
  static const DraftStep defendant = _$defendant;
  static const DraftStep review = _$review;

  int get index => switch (this) {
        DraftStep.overview => 0,
        DraftStep.plaintiff => 1,
        DraftStep.defendant => 2,
        DraftStep.review => 3,
        _ => 0,
      };

  static BuiltSet<DraftStep> get values => _$values;
  static DraftStep valueOf(String name) => _$valueOf(name);
  static Serializer<DraftStep> get serializer => _$draftStepSerializer;
}

abstract class CaseDraftState
    implements Built<CaseDraftState, CaseDraftStateBuilder> {
  CaseDraftState._();
  factory CaseDraftState([void Function(CaseDraftStateBuilder) updates]) =
      _$CaseDraftState;

  String? get draftId;
  DraftStep get activeStep;
  String get title;
  CaseCategory get category;
  String? get description;
  String get plaintiffName;
  String get plaintiffArgument;
  String get defendantName;
  String get defendantArgument;
  String? get suggestedCaseId;

  bool get isSubmitting;
  BuiltMap<String, String> get fieldErrors;

  bool get isOverviewValid => title.trim().isNotEmpty;
  bool get isPlaintiffValid =>
      plaintiffName.trim().isNotEmpty && plaintiffArgument.trim().isNotEmpty;
  bool get isDefendantValid =>
      defendantName.trim().isNotEmpty && defendantArgument.trim().isNotEmpty;
  bool get canSubmit =>
      isOverviewValid && isPlaintiffValid && isDefendantValid && !isSubmitting;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CaseDraftState.serializer, this)!
        as Map<String, dynamic>;
  }

  static CaseDraftState fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CaseDraftState.serializer, json)!;
  }

  static Serializer<CaseDraftState> get serializer =>
      _$caseDraftStateSerializer;

  static void _initializeBuilder(CaseDraftStateBuilder b) => b
    ..activeStep = DraftStep.overview
    ..title = ''
    ..category = CaseCategory.food
    ..description = ''
    ..plaintiffName = ''
    ..plaintiffArgument = ''
    ..defendantName = ''
    ..defendantArgument = ''
    ..isSubmitting = false
    ..fieldErrors = MapBuilder<String, String>();

  factory CaseDraftState.initial() => CaseDraftState();
}
