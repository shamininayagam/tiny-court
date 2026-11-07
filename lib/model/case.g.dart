// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Case> _$caseSerializer = _$CaseSerializer();

class _$CaseSerializer implements StructuredSerializer<Case> {
  @override
  final Iterable<Type> types = const [Case, _$Case];
  @override
  final String wireName = 'Case';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Case object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'caseNumber',
      serializers.serialize(
        object.caseNumber,
        specifiedType: const FullType(String),
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
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(CaseStatus),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      ),
    ];
    Object? value;
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.verdictId;
    if (value != null) {
      result
        ..add('verdictId')
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
  Case deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CaseBuilder();

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
        case 'caseNumber':
          result.caseNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String?;
          break;
        case 'category':
          result.category =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(CaseCategory),
                  )!
                  as CaseCategory;
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
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(CaseStatus),
                  )!
                  as CaseStatus;
          break;
        case 'verdictId':
          result.verdictId = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String?;
          break;
        case 'suggestedCaseId':
          result.suggestedCaseId = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String?;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )!
                  as DateTime;
          break;
        case 'updatedAt':
          result.updatedAt =
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

class _$Case extends Case {
  @override
  final String id;
  @override
  final String caseNumber;
  @override
  final String title;
  @override
  final String? description;
  @override
  final CaseCategory category;
  @override
  final String plaintiffName;
  @override
  final String plaintiffArgument;
  @override
  final String defendantName;
  @override
  final String defendantArgument;
  @override
  final CaseStatus status;
  @override
  final String? verdictId;
  @override
  final String? suggestedCaseId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$Case([void Function(CaseBuilder)? updates]) =>
      (CaseBuilder()..update(updates))._build();

  _$Case._({
    required this.id,
    required this.caseNumber,
    required this.title,
    this.description,
    required this.category,
    required this.plaintiffName,
    required this.plaintiffArgument,
    required this.defendantName,
    required this.defendantArgument,
    required this.status,
    this.verdictId,
    this.suggestedCaseId,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  Case rebuild(void Function(CaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CaseBuilder toBuilder() => CaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Case &&
        id == other.id &&
        caseNumber == other.caseNumber &&
        title == other.title &&
        description == other.description &&
        category == other.category &&
        plaintiffName == other.plaintiffName &&
        plaintiffArgument == other.plaintiffArgument &&
        defendantName == other.defendantName &&
        defendantArgument == other.defendantArgument &&
        status == other.status &&
        verdictId == other.verdictId &&
        suggestedCaseId == other.suggestedCaseId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, caseNumber.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, plaintiffName.hashCode);
    _$hash = $jc(_$hash, plaintiffArgument.hashCode);
    _$hash = $jc(_$hash, defendantName.hashCode);
    _$hash = $jc(_$hash, defendantArgument.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, verdictId.hashCode);
    _$hash = $jc(_$hash, suggestedCaseId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Case')
          ..add('id', id)
          ..add('caseNumber', caseNumber)
          ..add('title', title)
          ..add('description', description)
          ..add('category', category)
          ..add('plaintiffName', plaintiffName)
          ..add('plaintiffArgument', plaintiffArgument)
          ..add('defendantName', defendantName)
          ..add('defendantArgument', defendantArgument)
          ..add('status', status)
          ..add('verdictId', verdictId)
          ..add('suggestedCaseId', suggestedCaseId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class CaseBuilder implements Builder<Case, CaseBuilder> {
  _$Case? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _caseNumber;
  String? get caseNumber => _$this._caseNumber;
  set caseNumber(String? caseNumber) => _$this._caseNumber = caseNumber;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CaseCategory? _category;
  CaseCategory? get category => _$this._category;
  set category(CaseCategory? category) => _$this._category = category;

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

  CaseStatus? _status;
  CaseStatus? get status => _$this._status;
  set status(CaseStatus? status) => _$this._status = status;

  String? _verdictId;
  String? get verdictId => _$this._verdictId;
  set verdictId(String? verdictId) => _$this._verdictId = verdictId;

  String? _suggestedCaseId;
  String? get suggestedCaseId => _$this._suggestedCaseId;
  set suggestedCaseId(String? suggestedCaseId) =>
      _$this._suggestedCaseId = suggestedCaseId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  CaseBuilder();

  CaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _caseNumber = $v.caseNumber;
      _title = $v.title;
      _description = $v.description;
      _category = $v.category;
      _plaintiffName = $v.plaintiffName;
      _plaintiffArgument = $v.plaintiffArgument;
      _defendantName = $v.defendantName;
      _defendantArgument = $v.defendantArgument;
      _status = $v.status;
      _verdictId = $v.verdictId;
      _suggestedCaseId = $v.suggestedCaseId;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Case other) {
    _$v = other as _$Case;
  }

  @override
  void update(void Function(CaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Case build() => _build();

  _$Case _build() {
    final _$result =
        _$v ??
        _$Case._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Case', 'id'),
          caseNumber: BuiltValueNullFieldError.checkNotNull(
            caseNumber,
            r'Case',
            'caseNumber',
          ),
          title: BuiltValueNullFieldError.checkNotNull(title, r'Case', 'title'),
          description: description,
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'Case',
            'category',
          ),
          plaintiffName: BuiltValueNullFieldError.checkNotNull(
            plaintiffName,
            r'Case',
            'plaintiffName',
          ),
          plaintiffArgument: BuiltValueNullFieldError.checkNotNull(
            plaintiffArgument,
            r'Case',
            'plaintiffArgument',
          ),
          defendantName: BuiltValueNullFieldError.checkNotNull(
            defendantName,
            r'Case',
            'defendantName',
          ),
          defendantArgument: BuiltValueNullFieldError.checkNotNull(
            defendantArgument,
            r'Case',
            'defendantArgument',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'Case',
            'status',
          ),
          verdictId: verdictId,
          suggestedCaseId: suggestedCaseId,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'Case',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'Case',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
