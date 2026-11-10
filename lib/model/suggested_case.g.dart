// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_case.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SuggestedCase> _$suggestedCaseSerializer =
    _$SuggestedCaseSerializer();

class _$SuggestedCaseSerializer implements StructuredSerializer<SuggestedCase> {
  @override
  final Iterable<Type> types = const [SuggestedCase, _$SuggestedCase];
  @override
  final String wireName = 'SuggestedCase';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SuggestedCase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'description',
      serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      ),
      'category',
      serializers.serialize(
        object.category,
        specifiedType: const FullType(CaseCategory),
      ),
      'defaultPlaintiff',
      serializers.serialize(
        object.defaultPlaintiff,
        specifiedType: const FullType(String),
      ),
      'defaultDefendant',
      serializers.serialize(
        object.defaultDefendant,
        specifiedType: const FullType(String),
      ),
      'defaultPlaintiffArgument',
      serializers.serialize(
        object.defaultPlaintiffArgument,
        specifiedType: const FullType(String),
      ),
      'defaultDefendantArgument',
      serializers.serialize(
        object.defaultDefendantArgument,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  SuggestedCase deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SuggestedCaseBuilder();

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
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description =
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
        case 'defaultPlaintiff':
          result.defaultPlaintiff =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'defaultDefendant':
          result.defaultDefendant =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'defaultPlaintiffArgument':
          result.defaultPlaintiffArgument =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'defaultDefendantArgument':
          result.defaultDefendantArgument =
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

class _$SuggestedCase extends SuggestedCase {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final CaseCategory category;
  @override
  final String defaultPlaintiff;
  @override
  final String defaultDefendant;
  @override
  final String defaultPlaintiffArgument;
  @override
  final String defaultDefendantArgument;

  factory _$SuggestedCase([void Function(SuggestedCaseBuilder)? updates]) =>
      (SuggestedCaseBuilder()..update(updates))._build();

  _$SuggestedCase._({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.defaultPlaintiff,
    required this.defaultDefendant,
    required this.defaultPlaintiffArgument,
    required this.defaultDefendantArgument,
  }) : super._();
  @override
  SuggestedCase rebuild(void Function(SuggestedCaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuggestedCaseBuilder toBuilder() => SuggestedCaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuggestedCase &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        category == other.category &&
        defaultPlaintiff == other.defaultPlaintiff &&
        defaultDefendant == other.defaultDefendant &&
        defaultPlaintiffArgument == other.defaultPlaintiffArgument &&
        defaultDefendantArgument == other.defaultDefendantArgument;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, defaultPlaintiff.hashCode);
    _$hash = $jc(_$hash, defaultDefendant.hashCode);
    _$hash = $jc(_$hash, defaultPlaintiffArgument.hashCode);
    _$hash = $jc(_$hash, defaultDefendantArgument.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SuggestedCase')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('category', category)
          ..add('defaultPlaintiff', defaultPlaintiff)
          ..add('defaultDefendant', defaultDefendant)
          ..add('defaultPlaintiffArgument', defaultPlaintiffArgument)
          ..add('defaultDefendantArgument', defaultDefendantArgument))
        .toString();
  }
}

class SuggestedCaseBuilder
    implements Builder<SuggestedCase, SuggestedCaseBuilder> {
  _$SuggestedCase? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CaseCategory? _category;
  CaseCategory? get category => _$this._category;
  set category(CaseCategory? category) => _$this._category = category;

  String? _defaultPlaintiff;
  String? get defaultPlaintiff => _$this._defaultPlaintiff;
  set defaultPlaintiff(String? defaultPlaintiff) =>
      _$this._defaultPlaintiff = defaultPlaintiff;

  String? _defaultDefendant;
  String? get defaultDefendant => _$this._defaultDefendant;
  set defaultDefendant(String? defaultDefendant) =>
      _$this._defaultDefendant = defaultDefendant;

  String? _defaultPlaintiffArgument;
  String? get defaultPlaintiffArgument => _$this._defaultPlaintiffArgument;
  set defaultPlaintiffArgument(String? defaultPlaintiffArgument) =>
      _$this._defaultPlaintiffArgument = defaultPlaintiffArgument;

  String? _defaultDefendantArgument;
  String? get defaultDefendantArgument => _$this._defaultDefendantArgument;
  set defaultDefendantArgument(String? defaultDefendantArgument) =>
      _$this._defaultDefendantArgument = defaultDefendantArgument;

  SuggestedCaseBuilder();

  SuggestedCaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _category = $v.category;
      _defaultPlaintiff = $v.defaultPlaintiff;
      _defaultDefendant = $v.defaultDefendant;
      _defaultPlaintiffArgument = $v.defaultPlaintiffArgument;
      _defaultDefendantArgument = $v.defaultDefendantArgument;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuggestedCase other) {
    _$v = other as _$SuggestedCase;
  }

  @override
  void update(void Function(SuggestedCaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuggestedCase build() => _build();

  _$SuggestedCase _build() {
    final _$result =
        _$v ??
        _$SuggestedCase._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SuggestedCase', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'SuggestedCase',
            'title',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'SuggestedCase',
            'description',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'SuggestedCase',
            'category',
          ),
          defaultPlaintiff: BuiltValueNullFieldError.checkNotNull(
            defaultPlaintiff,
            r'SuggestedCase',
            'defaultPlaintiff',
          ),
          defaultDefendant: BuiltValueNullFieldError.checkNotNull(
            defaultDefendant,
            r'SuggestedCase',
            'defaultDefendant',
          ),
          defaultPlaintiffArgument: BuiltValueNullFieldError.checkNotNull(
            defaultPlaintiffArgument,
            r'SuggestedCase',
            'defaultPlaintiffArgument',
          ),
          defaultDefendantArgument: BuiltValueNullFieldError.checkNotNull(
            defaultDefendantArgument,
            r'SuggestedCase',
            'defaultDefendantArgument',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
