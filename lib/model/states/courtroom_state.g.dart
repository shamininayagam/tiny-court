// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courtroom_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CourtroomStage _$entrance = const CourtroomStage._('entrance');
const CourtroomStage _$judgeIntro = const CourtroomStage._('judgeIntro');
const CourtroomStage _$plaintiffPresentation = const CourtroomStage._(
  'plaintiffPresentation',
);
const CourtroomStage _$defendantPresentation = const CourtroomStage._(
  'defendantPresentation',
);
const CourtroomStage _$deliberation = const CourtroomStage._('deliberation');
const CourtroomStage _$verdictReveal = const CourtroomStage._('verdictReveal');
const CourtroomStage _$adjourned = const CourtroomStage._('adjourned');

CourtroomStage _$valueOf(String name) {
  switch (name) {
    case 'entrance':
      return _$entrance;
    case 'judgeIntro':
      return _$judgeIntro;
    case 'plaintiffPresentation':
      return _$plaintiffPresentation;
    case 'defendantPresentation':
      return _$defendantPresentation;
    case 'deliberation':
      return _$deliberation;
    case 'verdictReveal':
      return _$verdictReveal;
    case 'adjourned':
      return _$adjourned;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CourtroomStage> _$values = BuiltSet<CourtroomStage>(
  const <CourtroomStage>[
    _$entrance,
    _$judgeIntro,
    _$plaintiffPresentation,
    _$defendantPresentation,
    _$deliberation,
    _$verdictReveal,
    _$adjourned,
  ],
);

Serializer<CourtroomStage> _$courtroomStageSerializer =
    _$CourtroomStageSerializer();
Serializer<CourtroomState> _$courtroomStateSerializer =
    _$CourtroomStateSerializer();

class _$CourtroomStageSerializer
    implements PrimitiveSerializer<CourtroomStage> {
  @override
  final Iterable<Type> types = const <Type>[CourtroomStage];
  @override
  final String wireName = 'CourtroomStage';

  @override
  Object serialize(
    Serializers serializers,
    CourtroomStage object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  CourtroomStage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CourtroomStage.valueOf(serialized as String);
}

class _$CourtroomStateSerializer
    implements StructuredSerializer<CourtroomState> {
  @override
  final Iterable<Type> types = const [CourtroomState, _$CourtroomState];
  @override
  final String wireName = 'CourtroomState';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CourtroomState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'currentStage',
      serializers.serialize(
        object.currentStage,
        specifiedType: const FullType(CourtroomStage),
      ),
      'isAutoPlaying',
      serializers.serialize(
        object.isAutoPlaying,
        specifiedType: const FullType(bool),
      ),
      'isSkipped',
      serializers.serialize(
        object.isSkipped,
        specifiedType: const FullType(bool),
      ),
      'currentJudgeDialogue',
      serializers.serialize(
        object.currentJudgeDialogue,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.courtCase;
    if (value != null) {
      result
        ..add('courtCase')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(Case)),
        );
    }
    value = object.generatedVerdict;
    if (value != null) {
      result
        ..add('generatedVerdict')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(Verdict)),
        );
    }
    return result;
  }

  @override
  CourtroomState deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CourtroomStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'courtCase':
          result.courtCase.replace(
            serializers.deserialize(value, specifiedType: const FullType(Case))!
                as Case,
          );
          break;
        case 'currentStage':
          result.currentStage =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(CourtroomStage),
                  )!
                  as CourtroomStage;
          break;
        case 'generatedVerdict':
          result.generatedVerdict.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(Verdict),
                )!
                as Verdict,
          );
          break;
        case 'isAutoPlaying':
          result.isAutoPlaying =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'isSkipped':
          result.isSkipped =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'currentJudgeDialogue':
          result.currentJudgeDialogue =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CourtroomState extends CourtroomState {
  @override
  final Case? courtCase;
  @override
  final CourtroomStage currentStage;
  @override
  final Verdict? generatedVerdict;
  @override
  final bool isAutoPlaying;
  @override
  final bool isSkipped;
  @override
  final String currentJudgeDialogue;

  factory _$CourtroomState([void Function(CourtroomStateBuilder)? updates]) =>
      (CourtroomStateBuilder()..update(updates))._build();

  _$CourtroomState._({
    this.courtCase,
    required this.currentStage,
    this.generatedVerdict,
    required this.isAutoPlaying,
    required this.isSkipped,
    required this.currentJudgeDialogue,
  }) : super._();
  @override
  CourtroomState rebuild(void Function(CourtroomStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CourtroomStateBuilder toBuilder() => CourtroomStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourtroomState &&
        courtCase == other.courtCase &&
        currentStage == other.currentStage &&
        generatedVerdict == other.generatedVerdict &&
        isAutoPlaying == other.isAutoPlaying &&
        isSkipped == other.isSkipped &&
        currentJudgeDialogue == other.currentJudgeDialogue;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, courtCase.hashCode);
    _$hash = $jc(_$hash, currentStage.hashCode);
    _$hash = $jc(_$hash, generatedVerdict.hashCode);
    _$hash = $jc(_$hash, isAutoPlaying.hashCode);
    _$hash = $jc(_$hash, isSkipped.hashCode);
    _$hash = $jc(_$hash, currentJudgeDialogue.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourtroomState')
          ..add('courtCase', courtCase)
          ..add('currentStage', currentStage)
          ..add('generatedVerdict', generatedVerdict)
          ..add('isAutoPlaying', isAutoPlaying)
          ..add('isSkipped', isSkipped)
          ..add('currentJudgeDialogue', currentJudgeDialogue))
        .toString();
  }
}

class CourtroomStateBuilder
    implements Builder<CourtroomState, CourtroomStateBuilder> {
  _$CourtroomState? _$v;

  CaseBuilder? _courtCase;
  CaseBuilder get courtCase => _$this._courtCase ??= CaseBuilder();
  set courtCase(CaseBuilder? courtCase) => _$this._courtCase = courtCase;

  CourtroomStage? _currentStage;
  CourtroomStage? get currentStage => _$this._currentStage;
  set currentStage(CourtroomStage? currentStage) =>
      _$this._currentStage = currentStage;

  VerdictBuilder? _generatedVerdict;
  VerdictBuilder get generatedVerdict =>
      _$this._generatedVerdict ??= VerdictBuilder();
  set generatedVerdict(VerdictBuilder? generatedVerdict) =>
      _$this._generatedVerdict = generatedVerdict;

  bool? _isAutoPlaying;
  bool? get isAutoPlaying => _$this._isAutoPlaying;
  set isAutoPlaying(bool? isAutoPlaying) =>
      _$this._isAutoPlaying = isAutoPlaying;

  bool? _isSkipped;
  bool? get isSkipped => _$this._isSkipped;
  set isSkipped(bool? isSkipped) => _$this._isSkipped = isSkipped;

  String? _currentJudgeDialogue;
  String? get currentJudgeDialogue => _$this._currentJudgeDialogue;
  set currentJudgeDialogue(String? currentJudgeDialogue) =>
      _$this._currentJudgeDialogue = currentJudgeDialogue;

  CourtroomStateBuilder() {
    CourtroomState._initializeBuilder(this);
  }

  CourtroomStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _courtCase = $v.courtCase?.toBuilder();
      _currentStage = $v.currentStage;
      _generatedVerdict = $v.generatedVerdict?.toBuilder();
      _isAutoPlaying = $v.isAutoPlaying;
      _isSkipped = $v.isSkipped;
      _currentJudgeDialogue = $v.currentJudgeDialogue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourtroomState other) {
    _$v = other as _$CourtroomState;
  }

  @override
  void update(void Function(CourtroomStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourtroomState build() => _build();

  _$CourtroomState _build() {
    _$CourtroomState _$result;
    try {
      _$result =
          _$v ??
          _$CourtroomState._(
            courtCase: _courtCase?.build(),
            currentStage: BuiltValueNullFieldError.checkNotNull(
              currentStage,
              r'CourtroomState',
              'currentStage',
            ),
            generatedVerdict: _generatedVerdict?.build(),
            isAutoPlaying: BuiltValueNullFieldError.checkNotNull(
              isAutoPlaying,
              r'CourtroomState',
              'isAutoPlaying',
            ),
            isSkipped: BuiltValueNullFieldError.checkNotNull(
              isSkipped,
              r'CourtroomState',
              'isSkipped',
            ),
            currentJudgeDialogue: BuiltValueNullFieldError.checkNotNull(
              currentJudgeDialogue,
              r'CourtroomState',
              'currentJudgeDialogue',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'courtCase';
        _courtCase?.build();

        _$failedField = 'generatedVerdict';
        _generatedVerdict?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CourtroomState',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
