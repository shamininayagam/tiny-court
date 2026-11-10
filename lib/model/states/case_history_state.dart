import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../case.dart';
import '../enums/case_category.dart';
import '../enums/case_status.dart';
import '../serializers.dart';

part 'case_history_state.g.dart';

abstract class CaseHistoryState
    implements Built<CaseHistoryState, CaseHistoryStateBuilder> {
  CaseHistoryState._();
  factory CaseHistoryState([void Function(CaseHistoryStateBuilder) updates]) =
      _$CaseHistoryState;

  BuiltList<Case> get allCases;
  BuiltList<Case> get filteredCases;
  String get searchQuery;
  CaseStatus? get selectedStatus;
  CaseCategory? get selectedCategory;
  bool get isLoading;
  String? get errorMessage;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CaseHistoryState.serializer, this)!
        as Map<String, dynamic>;
  }

  static CaseHistoryState fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CaseHistoryState.serializer, json)!;
  }

  static Serializer<CaseHistoryState> get serializer =>
      _$caseHistoryStateSerializer;

  static void _initializeBuilder(CaseHistoryStateBuilder b) => b
    ..allCases = ListBuilder<Case>()
    ..filteredCases = ListBuilder<Case>()
    ..searchQuery = ''
    ..isLoading = false;

  factory CaseHistoryState.initial() => CaseHistoryState();
}
