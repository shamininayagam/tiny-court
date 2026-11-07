import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../case.dart';
import '../serializers.dart';
import '../verdict.dart';

part 'courtroom_state.g.dart';

class CourtroomStage extends EnumClass {
  const CourtroomStage._(super.name);

  static const CourtroomStage entrance = _$entrance;
  static const CourtroomStage judgeIntro = _$judgeIntro;
  static const CourtroomStage plaintiffPresentation = _$plaintiffPresentation;
  static const CourtroomStage defendantPresentation = _$defendantPresentation;
  static const CourtroomStage deliberation = _$deliberation;
  static const CourtroomStage verdictReveal = _$verdictReveal;
  static const CourtroomStage adjourned = _$adjourned;

  static BuiltSet<CourtroomStage> get values => _$values;
  static CourtroomStage valueOf(String name) => _$valueOf(name);
  static Serializer<CourtroomStage> get serializer => _$courtroomStageSerializer;
}

abstract class CourtroomState
    implements Built<CourtroomState, CourtroomStateBuilder> {
  CourtroomState._();
  factory CourtroomState([void Function(CourtroomStateBuilder) updates]) =
      _$CourtroomState;

  Case? get courtCase;
  CourtroomStage get currentStage;
  Verdict? get generatedVerdict;
  bool get isAutoPlaying;
  bool get isSkipped;
  String get currentJudgeDialogue;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CourtroomState.serializer, this)!
        as Map<String, dynamic>;
  }

  static CourtroomState fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CourtroomState.serializer, json)!;
  }

  static Serializer<CourtroomState> get serializer =>
      _$courtroomStateSerializer;

  static void _initializeBuilder(CourtroomStateBuilder b) => b
    ..currentStage = CourtroomStage.entrance
    ..isAutoPlaying = true
    ..isSkipped = false
    ..currentJudgeDialogue = '';
}
