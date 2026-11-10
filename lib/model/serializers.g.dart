// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(ApiError.serializer)
          ..add(AppSettings.serializer)
          ..add(AppState.serializer)
          ..add(Case.serializer)
          ..add(CaseCategory.serializer)
          ..add(CaseDraftState.serializer)
          ..add(CaseHistoryState.serializer)
          ..add(CaseStatus.serializer)
          ..add(CourtroomStage.serializer)
          ..add(CourtroomState.serializer)
          ..add(DraftStep.serializer)
          ..add(SuggestedCase.serializer)
          ..add(Verdict.serializer)
          ..add(VerdictType.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Case)]),
            () => ListBuilder<Case>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Case)]),
            () => ListBuilder<Case>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(String),
            ]),
            () => MapBuilder<String, String>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
