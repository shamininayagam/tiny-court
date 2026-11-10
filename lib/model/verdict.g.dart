// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verdict.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Verdict> _$verdictSerializer = _$VerdictSerializer();

class _$VerdictSerializer implements StructuredSerializer<Verdict> {
  @override
  final Iterable<Type> types = const [Verdict, _$Verdict];
  @override
  final String wireName = 'Verdict';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Verdict object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'caseId',
      serializers.serialize(
        object.caseId,
        specifiedType: const FullType(String),
      ),
      'verdictType',
      serializers.serialize(
        object.verdictType,
        specifiedType: const FullType(VerdictType),
      ),
      'responsibleParties',
      serializers.serialize(
        object.responsibleParties,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'judgeStatement',
      serializers.serialize(
        object.judgeStatement,
        specifiedType: const FullType(String),
      ),
      'explanation',
      serializers.serialize(
        object.explanation,
        specifiedType: const FullType(String),
      ),
      'punishment',
      serializers.serialize(
        object.punishment,
        specifiedType: const FullType(String),
      ),
      'closingRemark',
      serializers.serialize(
        object.closingRemark,
        specifiedType: const FullType(String),
      ),
      'ruleId',
      serializers.serialize(
        object.ruleId,
        specifiedType: const FullType(String),
      ),
      'generatedAt',
      serializers.serialize(
        object.generatedAt,
        specifiedType: const FullType(DateTime),
      ),
    ];

    return result;
  }

  @override
  Verdict deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerdictBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'caseId':
          result.caseId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'verdictType':
          result.verdictType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(VerdictType),
                  )!
                  as VerdictType;
          break;
        case 'responsibleParties':
          result.responsibleParties.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'judgeStatement':
          result.judgeStatement =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'explanation':
          result.explanation =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'punishment':
          result.punishment =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'closingRemark':
          result.closingRemark =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'ruleId':
          result.ruleId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'generatedAt':
          result.generatedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )!
                  as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$Verdict extends Verdict {
  @override
  final String id;
  @override
  final String caseId;
  @override
  final VerdictType verdictType;
  @override
  final BuiltList<String> responsibleParties;
  @override
  final String judgeStatement;
  @override
  final String explanation;
  @override
  final String punishment;
  @override
  final String closingRemark;
  @override
  final String ruleId;
  @override
  final DateTime generatedAt;

  factory _$Verdict([void Function(VerdictBuilder)? updates]) =>
      (VerdictBuilder()..update(updates))._build();

  _$Verdict._({
    required this.id,
    required this.caseId,
    required this.verdictType,
    required this.responsibleParties,
    required this.judgeStatement,
    required this.explanation,
    required this.punishment,
    required this.closingRemark,
    required this.ruleId,
    required this.generatedAt,
  }) : super._();
  @override
  Verdict rebuild(void Function(VerdictBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerdictBuilder toBuilder() => VerdictBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Verdict &&
        id == other.id &&
        caseId == other.caseId &&
        verdictType == other.verdictType &&
        responsibleParties == other.responsibleParties &&
        judgeStatement == other.judgeStatement &&
        explanation == other.explanation &&
        punishment == other.punishment &&
        closingRemark == other.closingRemark &&
        ruleId == other.ruleId &&
        generatedAt == other.generatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, verdictType.hashCode);
    _$hash = $jc(_$hash, responsibleParties.hashCode);
    _$hash = $jc(_$hash, judgeStatement.hashCode);
    _$hash = $jc(_$hash, explanation.hashCode);
    _$hash = $jc(_$hash, punishment.hashCode);
    _$hash = $jc(_$hash, closingRemark.hashCode);
    _$hash = $jc(_$hash, ruleId.hashCode);
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Verdict')
          ..add('id', id)
          ..add('caseId', caseId)
          ..add('verdictType', verdictType)
          ..add('responsibleParties', responsibleParties)
          ..add('judgeStatement', judgeStatement)
          ..add('explanation', explanation)
          ..add('punishment', punishment)
          ..add('closingRemark', closingRemark)
          ..add('ruleId', ruleId)
          ..add('generatedAt', generatedAt))
        .toString();
  }
}

class VerdictBuilder implements Builder<Verdict, VerdictBuilder> {
  _$Verdict? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  VerdictType? _verdictType;
  VerdictType? get verdictType => _$this._verdictType;
  set verdictType(VerdictType? verdictType) =>
      _$this._verdictType = verdictType;

  ListBuilder<String>? _responsibleParties;
  ListBuilder<String> get responsibleParties =>
      _$this._responsibleParties ??= ListBuilder<String>();
  set responsibleParties(ListBuilder<String>? responsibleParties) =>
      _$this._responsibleParties = responsibleParties;

  String? _judgeStatement;
  String? get judgeStatement => _$this._judgeStatement;
  set judgeStatement(String? judgeStatement) =>
      _$this._judgeStatement = judgeStatement;

  String? _explanation;
  String? get explanation => _$this._explanation;
  set explanation(String? explanation) => _$this._explanation = explanation;

  String? _punishment;
  String? get punishment => _$this._punishment;
  set punishment(String? punishment) => _$this._punishment = punishment;

  String? _closingRemark;
  String? get closingRemark => _$this._closingRemark;
  set closingRemark(String? closingRemark) =>
      _$this._closingRemark = closingRemark;

  String? _ruleId;
  String? get ruleId => _$this._ruleId;
  set ruleId(String? ruleId) => _$this._ruleId = ruleId;

  DateTime? _generatedAt;
  DateTime? get generatedAt => _$this._generatedAt;
  set generatedAt(DateTime? generatedAt) => _$this._generatedAt = generatedAt;

  VerdictBuilder();

  VerdictBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _caseId = $v.caseId;
      _verdictType = $v.verdictType;
      _responsibleParties = $v.responsibleParties.toBuilder();
      _judgeStatement = $v.judgeStatement;
      _explanation = $v.explanation;
      _punishment = $v.punishment;
      _closingRemark = $v.closingRemark;
      _ruleId = $v.ruleId;
      _generatedAt = $v.generatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Verdict other) {
    _$v = other as _$Verdict;
  }

  @override
  void update(void Function(VerdictBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Verdict build() => _build();

  _$Verdict _build() {
    _$Verdict _$result;
    try {
      _$result =
          _$v ??
          _$Verdict._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Verdict', 'id'),
            caseId: BuiltValueNullFieldError.checkNotNull(
              caseId,
              r'Verdict',
              'caseId',
            ),
            verdictType: BuiltValueNullFieldError.checkNotNull(
              verdictType,
              r'Verdict',
              'verdictType',
            ),
            responsibleParties: responsibleParties.build(),
            judgeStatement: BuiltValueNullFieldError.checkNotNull(
              judgeStatement,
              r'Verdict',
              'judgeStatement',
            ),
            explanation: BuiltValueNullFieldError.checkNotNull(
              explanation,
              r'Verdict',
              'explanation',
            ),
            punishment: BuiltValueNullFieldError.checkNotNull(
              punishment,
              r'Verdict',
              'punishment',
            ),
            closingRemark: BuiltValueNullFieldError.checkNotNull(
              closingRemark,
              r'Verdict',
              'closingRemark',
            ),
            ruleId: BuiltValueNullFieldError.checkNotNull(
              ruleId,
              r'Verdict',
              'ruleId',
            ),
            generatedAt: BuiltValueNullFieldError.checkNotNull(
              generatedAt,
              r'Verdict',
              'generatedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'responsibleParties';
        responsibleParties.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'Verdict',
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
