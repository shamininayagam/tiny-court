// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_history_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CaseHistoryState> _$caseHistoryStateSerializer =
    _$CaseHistoryStateSerializer();

class _$CaseHistoryStateSerializer
    implements StructuredSerializer<CaseHistoryState> {
  @override
  final Iterable<Type> types = const [CaseHistoryState, _$CaseHistoryState];
  @override
  final String wireName = 'CaseHistoryState';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CaseHistoryState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'allCases',
      serializers.serialize(
        object.allCases,
        specifiedType: const FullType(BuiltList, const [const FullType(Case)]),
      ),
      'filteredCases',
      serializers.serialize(
        object.filteredCases,
        specifiedType: const FullType(BuiltList, const [const FullType(Case)]),
      ),
      'searchQuery',
      serializers.serialize(
        object.searchQuery,
        specifiedType: const FullType(String),
      ),
      'isLoading',
      serializers.serialize(
        object.isLoading,
        specifiedType: const FullType(bool),
      ),
    ];
    Object? value;
    value = object.selectedStatus;
    if (value != null) {
      result
        ..add('selectedStatus')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(CaseStatus),
          ),
        );
    }
    value = object.selectedCategory;
    if (value != null) {
      result
        ..add('selectedCategory')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(CaseCategory),
          ),
        );
    }
    value = object.errorMessage;
    if (value != null) {
      result
        ..add('errorMessage')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  CaseHistoryState deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CaseHistoryStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'allCases':
          result.allCases.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(Case),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'filteredCases':
          result.filteredCases.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(Case),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'searchQuery':
          result.searchQuery =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'selectedStatus':
          result.selectedStatus = serializers.deserialize(
            value,
            specifiedType: const FullType(CaseStatus),
          ) as CaseStatus?;
          break;
        case 'selectedCategory':
          result.selectedCategory = serializers.deserialize(
            value,
            specifiedType: const FullType(CaseCategory),
          ) as CaseCategory?;
          break;
        case 'isLoading':
          result.isLoading =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$CaseHistoryState extends CaseHistoryState {
  @override
  final BuiltList<Case> allCases;
  @override
  final BuiltList<Case> filteredCases;
  @override
  final String searchQuery;
  @override
  final CaseStatus? selectedStatus;
  @override
  final CaseCategory? selectedCategory;
  @override
  final bool isLoading;
  @override
  final String? errorMessage;

  factory _$CaseHistoryState([
    void Function(CaseHistoryStateBuilder)? updates,
  ]) => (CaseHistoryStateBuilder()..update(updates))._build();

  _$CaseHistoryState._({
    required this.allCases,
    required this.filteredCases,
    required this.searchQuery,
    this.selectedStatus,
    this.selectedCategory,
    required this.isLoading,
    this.errorMessage,
  }) : super._();
  @override
  CaseHistoryState rebuild(void Function(CaseHistoryStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CaseHistoryStateBuilder toBuilder() =>
      CaseHistoryStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CaseHistoryState &&
        allCases == other.allCases &&
        filteredCases == other.filteredCases &&
        searchQuery == other.searchQuery &&
        selectedStatus == other.selectedStatus &&
        selectedCategory == other.selectedCategory &&
        isLoading == other.isLoading &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, allCases.hashCode);
    _$hash = $jc(_$hash, filteredCases.hashCode);
    _$hash = $jc(_$hash, searchQuery.hashCode);
    _$hash = $jc(_$hash, selectedStatus.hashCode);
    _$hash = $jc(_$hash, selectedCategory.hashCode);
    _$hash = $jc(_$hash, isLoading.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CaseHistoryState')
          ..add('allCases', allCases)
          ..add('filteredCases', filteredCases)
          ..add('searchQuery', searchQuery)
          ..add('selectedStatus', selectedStatus)
          ..add('selectedCategory', selectedCategory)
          ..add('isLoading', isLoading)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class CaseHistoryStateBuilder
    implements Builder<CaseHistoryState, CaseHistoryStateBuilder> {
  _$CaseHistoryState? _$v;

  ListBuilder<Case>? _allCases;
  ListBuilder<Case> get allCases => _$this._allCases ??= ListBuilder<Case>();
  set allCases(ListBuilder<Case>? allCases) => _$this._allCases = allCases;

  ListBuilder<Case>? _filteredCases;
  ListBuilder<Case> get filteredCases =>
      _$this._filteredCases ??= ListBuilder<Case>();
  set filteredCases(ListBuilder<Case>? filteredCases) =>
      _$this._filteredCases = filteredCases;

  String? _searchQuery;
  String? get searchQuery => _$this._searchQuery;
  set searchQuery(String? searchQuery) => _$this._searchQuery = searchQuery;

  CaseStatus? _selectedStatus;
  CaseStatus? get selectedStatus => _$this._selectedStatus;
  set selectedStatus(CaseStatus? selectedStatus) =>
      _$this._selectedStatus = selectedStatus;

  CaseCategory? _selectedCategory;
  CaseCategory? get selectedCategory => _$this._selectedCategory;
  set selectedCategory(CaseCategory? selectedCategory) =>
      _$this._selectedCategory = selectedCategory;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  CaseHistoryStateBuilder() {
    CaseHistoryState._initializeBuilder(this);
  }

  CaseHistoryStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _allCases = $v.allCases.toBuilder();
      _filteredCases = $v.filteredCases.toBuilder();
      _searchQuery = $v.searchQuery;
      _selectedStatus = $v.selectedStatus;
      _selectedCategory = $v.selectedCategory;
      _isLoading = $v.isLoading;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CaseHistoryState other) {
    _$v = other as _$CaseHistoryState;
  }

  @override
  void update(void Function(CaseHistoryStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CaseHistoryState build() => _build();

  _$CaseHistoryState _build() {
    _$CaseHistoryState _$result;
    try {
      _$result =
          _$v ??
          _$CaseHistoryState._(
            allCases: allCases.build(),
            filteredCases: filteredCases.build(),
            searchQuery: BuiltValueNullFieldError.checkNotNull(
              searchQuery,
              r'CaseHistoryState',
              'searchQuery',
            ),
            selectedStatus: selectedStatus,
            selectedCategory: selectedCategory,
            isLoading: BuiltValueNullFieldError.checkNotNull(
              isLoading,
              r'CaseHistoryState',
              'isLoading',
            ),
            errorMessage: errorMessage,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'allCases';
        allCases.build();
        _$failedField = 'filteredCases';
        filteredCases.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CaseHistoryState',
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
