# Case History & Filter ViewModel Specification

| Field | Value |
|---|---|
| Spec | Case History, Search & Filtering State Machine |
| Target Path | `lib/view_model/case_history/case_history_notifier.dart` |
| Target Route | `/cases` |

---

## 1. Responsibilities

1. Reactive list of all saved cases.
2. Filtering by `CaseStatus` (`all`, `draft`, `submitted`, `decided`).
3. Filtering by `CaseCategory` (`food`, `friendship`, `relationships`, `work`, `random`).
4. Instant search query matching against `title`, `plaintiffName`, and `defendantName`.
5. Case deletion with undo or confirmation.

---

## 2. BuiltValue State Model: `CaseHistoryState`

```dart
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/enums/case_status.dart';

part 'case_history_state.g.dart';

abstract class CaseHistoryState implements Built<CaseHistoryState, CaseHistoryStateBuilder> {
  CaseHistoryState._();
  factory CaseHistoryState([void Function(CaseHistoryStateBuilder) updates]) = _$CaseHistoryState;

  BuiltList<Case> get allCases;
  BuiltList<Case> get filteredCases;
  String get searchQuery;
  CaseStatus? get selectedStatus;
  CaseCategory? get selectedCategory;
  bool get isLoading;
  String? get errorMessage;

  static Serializer<CaseHistoryState> get serializer => _$caseHistoryStateSerializer;
}
```

---

## 3. Notifier Contract

```dart
abstract interface class CaseHistoryNotifierContract {
  Future<void> loadCases();
  void setSearchQuery(String query);
  void setStatusFilter(CaseStatus? status);
  void setCategoryFilter(CaseCategory? category);
  void clearFilters();
  Future<void> deleteCase(String id);
}
```
