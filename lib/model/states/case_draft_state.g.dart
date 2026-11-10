// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_draft_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DraftStep _$overview = const DraftStep._('overview');
const DraftStep _$plaintiff = const DraftStep._('plaintiff');
const DraftStep _$defendant = const DraftStep._('defendant');
const DraftStep _$review = const DraftStep._('review');

DraftStep _$valueOf(String name) {
  switch (name) {
    case 'overview':
      return _$overview;
    case 'plaintiff':
      return _$plaintiff;
    case 'defendant':
      return _$defendant;
    case 'review':
      return _$review;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DraftStep> _$values = BuiltSet<DraftStep>(const <DraftStep>[
  _$overview,
  _$plaintiff,
  _$defendant,
  _$review,
]);

Serializer<DraftStep> _$draftStepSerializer = _$DraftStepSerializer();
Serializer<CaseDraftState> _$caseDraftStateSerializer =
    _$CaseDraftStateSerializer();

class _$DraftStepSerializer implements PrimitiveSerializer<DraftStep> {
  @override
  final Iterable<Type> types = const <Type>[DraftStep];
  @override
  final String wireName = 'DraftStep';

  @override
  Object serialize(
    Serializers serializers,
    DraftStep object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  DraftStep deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DraftStep.valueOf(serialized as String);
}

class _$CaseDraftStateSerializer
    implements StructuredSerializer<CaseDraftState> {
  @override
  final Iterable<Type> types = const [CaseDraftState, _$CaseDraftState];
  @override
  final String wireName = 'CaseDraftState';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CaseDraftState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'activeStep',
      serializers.serialize(
        object.activeStep,
        specifiedType: const FullType(DraftStep),
      ),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'category',
      serializers.serialize(
        object.category,
        specifiedType: const FullType(CaseCategory),
      ),
      'plaintiffName',
      serializers.serialize(
        object.plaintiffName,
        specifiedType: const FullType(String),
      ),
      'plaintiffArgument',
      serializers.serialize(
        object.plaintiffArgument,
        specifiedType: const FullType(String),
      ),
      'defendantName',
      serializers.serialize(
        object.defendantName,
        specifiedType: const FullType(String),
      ),
      'defendantArgument',
      serializers.serialize(
        object.defendantArgument,
        specifiedType: const FullType(String),
      ),
      'isSubmitting',
      serializers.serialize(
        object.isSubmitting,
        specifiedType: const FullType(bool),
      ),
      'fieldErrors',
      serializers.serialize(
        object.fieldErrors,
        specifiedType: const FullType(BuiltMap, const [
          const FullType(String),
          const FullType(String),
        ]),
      ),
    ];
    Object? value;
    value = object.draftId;
    if (value != null) {
      result
        ..add('draftId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.suggestedCaseId;
    if (value != null) {
      result
        ..add('suggestedCaseId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  CaseDraftState deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CaseDraftStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'draftId':
          result.draftId = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String?;
          break;
        case 'activeStep':
          result.activeStep =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DraftStep),
                  )!
                  as DraftStep;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'category':
          result.category =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(CaseCategory),
                  )!
                  as CaseCategory;
          break;
        case 'description':
          result.description = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String?;
          break;
        case 'plaintiffName':
          result.plaintiffName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'plaintiffArgument':
          result.plaintiffArgument =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'defendantName':
          result.defendantName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'defendantArgument':
          result.defendantArgument =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'suggestedCaseId':
          result.suggestedCaseId = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String?;
          break;
        case 'isSubmitting':
          result.isSubmitting =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'fieldErrors':
          result.fieldErrors.replace(
            serializers.deserialize(
              value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(String),
              ]),
            )!,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$CaseDraftState extends CaseDraftState {
  @override
  final String? draftId;
  @override
  final DraftStep activeStep;
  @override
  final String title;
  @override
  final CaseCategory category;
  @override
  final String? description;
  @override
  final String plaintiffName;
  @override
  final String plaintiffArgument;
  @override
  final String defendantName;
  @override
  final String defendantArgument;
  @override
  final String? suggestedCaseId;
  @override
  final bool isSubmitting;
  @override
  final BuiltMap<String, String> fieldErrors;

  factory _$CaseDraftState([void Function(CaseDraftStateBuilder)? updates]) =>
      (CaseDraftStateBuilder()..update(updates))._build();

  _$CaseDraftState._({
    this.draftId,
    required this.activeStep,
    required this.title,
    required this.category,
    this.description,
    required this.plaintiffName,
    required this.plaintiffArgument,
    required this.defendantName,
    required this.defendantArgument,
    this.suggestedCaseId,
    required this.isSubmitting,
    required this.fieldErrors,
  }) : super._();
  @override
  CaseDraftState rebuild(void Function(CaseDraftStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CaseDraftStateBuilder toBuilder() => CaseDraftStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CaseDraftState &&
        draftId == other.draftId &&
        activeStep == other.activeStep &&
        title == other.title &&
        category == other.category &&
        description == other.description &&
        plaintiffName == other.plaintiffName &&
        plaintiffArgument == other.plaintiffArgument &&
        defendantName == other.defendantName &&
        defendantArgument == other.defendantArgument &&
        suggestedCaseId == other.suggestedCaseId &&
        isSubmitting == other.isSubmitting &&
        fieldErrors == other.fieldErrors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, draftId.hashCode);
    _$hash = $jc(_$hash, activeStep.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, plaintiffName.hashCode);
    _$hash = $jc(_$hash, plaintiffArgument.hashCode);
    _$hash = $jc(_$hash, defendantName.hashCode);
    _$hash = $jc(_$hash, defendantArgument.hashCode);
    _$hash = $jc(_$hash, suggestedCaseId.hashCode);
    _$hash = $jc(_$hash, isSubmitting.hashCode);
    _$hash = $jc(_$hash, fieldErrors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CaseDraftState')
          ..add('draftId', draftId)
          ..add('activeStep', activeStep)
          ..add('title', title)
          ..add('category', category)
          ..add('description', description)
          ..add('plaintiffName', plaintiffName)
          ..add('plaintiffArgument', plaintiffArgument)
          ..add('defendantName', defendantName)
          ..add('defendantArgument', defendantArgument)
          ..add('suggestedCaseId', suggestedCaseId)
          ..add('isSubmitting', isSubmitting)
          ..add('fieldErrors', fieldErrors))
        .toString();
  }
}

class CaseDraftStateBuilder
    implements Builder<CaseDraftState, CaseDraftStateBuilder> {
  _$CaseDraftState? _$v;

  String? _draftId;
  String? get draftId => _$this._draftId;
  set draftId(String? draftId) => _$this._draftId = draftId;

  DraftStep? _activeStep;
  DraftStep? get activeStep => _$this._activeStep;
  set activeStep(DraftStep? activeStep) => _$this._activeStep = activeStep;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CaseCategory? _category;
  CaseCategory? get category => _$this._category;
  set category(CaseCategory? category) => _$this._category = category;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _plaintiffName;
  String? get plaintiffName => _$this._plaintiffName;
  set plaintiffName(String? plaintiffName) =>
      _$this._plaintiffName = plaintiffName;

  String? _plaintiffArgument;
  String? get plaintiffArgument => _$this._plaintiffArgument;
  set plaintiffArgument(String? plaintiffArgument) =>
      _$this._plaintiffArgument = plaintiffArgument;

  String? _defendantName;
  String? get defendantName => _$this._defendantName;
  set defendantName(String? defendantName) =>
      _$this._defendantName = defendantName;

  String? _defendantArgument;
  String? get defendantArgument => _$this._defendantArgument;
  set defendantArgument(String? defendantArgument) =>
      _$this._defendantArgument = defendantArgument;

  String? _suggestedCaseId;
  String? get suggestedCaseId => _$this._suggestedCaseId;
  set suggestedCaseId(String? suggestedCaseId) =>
      _$this._suggestedCaseId = suggestedCaseId;

  bool? _isSubmitting;
  bool? get isSubmitting => _$this._isSubmitting;
  set isSubmitting(bool? isSubmitting) => _$this._isSubmitting = isSubmitting;

  MapBuilder<String, String>? _fieldErrors;
  MapBuilder<String, String> get fieldErrors =>
      _$this._fieldErrors ??= MapBuilder<String, String>();
  set fieldErrors(MapBuilder<String, String>? fieldErrors) =>
      _$this._fieldErrors = fieldErrors;

  CaseDraftStateBuilder() {
    CaseDraftState._initializeBuilder(this);
  }

  CaseDraftStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _draftId = $v.draftId;
      _activeStep = $v.activeStep;
      _title = $v.title;
      _category = $v.category;
      _description = $v.description;
      _plaintiffName = $v.plaintiffName;
      _plaintiffArgument = $v.plaintiffArgument;
      _defendantName = $v.defendantName;
      _defendantArgument = $v.defendantArgument;
      _suggestedCaseId = $v.suggestedCaseId;
      _isSubmitting = $v.isSubmitting;
      _fieldErrors = $v.fieldErrors.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CaseDraftState other) {
    _$v = other as _$CaseDraftState;
  }

  @override
  void update(void Function(CaseDraftStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CaseDraftState build() => _build();

  _$CaseDraftState _build() {
    _$CaseDraftState _$result;
    try {
      _$result =
          _$v ??
          _$CaseDraftState._(
            draftId: draftId,
            activeStep: BuiltValueNullFieldError.checkNotNull(
              activeStep,
              r'CaseDraftState',
              'activeStep',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'CaseDraftState',
              'title',
            ),
            category: BuiltValueNullFieldError.checkNotNull(
              category,
              r'CaseDraftState',
              'category',
            ),
            description: description,
            plaintiffName: BuiltValueNullFieldError.checkNotNull(
              plaintiffName,
              r'CaseDraftState',
              'plaintiffName',
            ),
            plaintiffArgument: BuiltValueNullFieldError.checkNotNull(
              plaintiffArgument,
              r'CaseDraftState',
              'plaintiffArgument',
            ),
            defendantName: BuiltValueNullFieldError.checkNotNull(
              defendantName,
              r'CaseDraftState',
              'defendantName',
            ),
            defendantArgument: BuiltValueNullFieldError.checkNotNull(
              defendantArgument,
              r'CaseDraftState',
              'defendantArgument',
            ),
            suggestedCaseId: suggestedCaseId,
            isSubmitting: BuiltValueNullFieldError.checkNotNull(
              isSubmitting,
              r'CaseDraftState',
              'isSubmitting',
            ),
            fieldErrors: fieldErrors.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fieldErrors';
        fieldErrors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CaseDraftState',
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
