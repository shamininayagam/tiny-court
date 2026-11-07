# Case CRUD Service Specification & Contract

| Field | Value |
|---|---|
| Spec | Case CRUD & Lifecycle Contract |
| Contract | [`CaseService`](../../lib/core/services/case_service.dart) |
| Model | [`Case`](../../lib/model/case.dart) (Built Value) |
| Enums | [`CaseCategory`](../../lib/model/enums/case_category.dart), [`CaseStatus`](../../lib/model/enums/case_status.dart) |
| Reference | `pogo_alarm/app/docs/service_plans/01-database-and-alarm-service-contract.md` |

---

## 1. BuiltValue Domain Enums (`EnumClass`)

To ensure seamless integration with `built_value`, code generation, and `serializers.dart`, all enums extend `EnumClass`.

### `CaseCategory` (`lib/model/enums/case_category.dart`)
```dart
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'case_category.g.dart';

class CaseCategory extends EnumClass {
  const CaseCategory._(super.name);

  static const CaseCategory food = _$food;
  static const CaseCategory friendship = _$friendship;
  static const CaseCategory relationships = _$relationships;
  static const CaseCategory work = _$work;
  static const CaseCategory random = _$random;

  String get displayName => switch (this) {
    CaseCategory.food => 'Food & Snacks',
    CaseCategory.friendship => 'Friendship',
    CaseCategory.relationships => 'Romance & Dating',
    CaseCategory.work => 'Work & Chores',
    CaseCategory.random => 'Random Petty Crimes',
    _ => name,
  };

  static BuiltSet<CaseCategory> get values => _$values;
  static CaseCategory valueOf(String name) => _$valueOf(name);
  static Serializer<CaseCategory> get serializer => _$caseCategorySerializer;
}
```

### `CaseStatus` (`lib/model/enums/case_status.dart`)
```dart
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'case_status.g.dart';

class CaseStatus extends EnumClass {
  const CaseStatus._(super.name);

  static const CaseStatus draft = _$draft;         // In-progress creation; editable
  static const CaseStatus submitted = _$submitted; // Submitted to court; ready for trial
  static const CaseStatus decided = _$decided;     // Trial complete; verdict rendered; immutable

  static BuiltSet<CaseStatus> get values => _$values;
  static CaseStatus valueOf(String name) => _$valueOf(name);
  static Serializer<CaseStatus> get serializer => _$caseStatusSerializer;
}
```

---

## 2. Domain Model: `Case` (`lib/model/case.dart`)

```dart
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'enums/case_category.dart';
import 'enums/case_status.dart';

part 'case.g.dart';

abstract class Case implements Built<Case, CaseBuilder> {
  Case._();
  factory Case([void Function(CaseBuilder) updates]) = _$Case;

  String get id;
  String get caseNumber; // Format: TC-YYYY-XXXXX
  String get title;
  String? get description;
  CaseCategory get category;

  String get plaintiffName;
  String get plaintiffArgument;

  String get defendantName;
  String get defendantArgument;

  CaseStatus get status;
  String? get verdictId; // Null until case is decided
  String? get suggestedCaseId; // Null if created from scratch

  DateTime get createdAt;
  DateTime get updatedAt;

  static Serializer<Case> get serializer => _$caseSerializer;
}
```

---

## 3. Core Contract: `CaseService` (`lib/core/services/case_service.dart`)

```dart
import '../services/service.dart';
import '../../model/case.dart';
import '../../model/suggested_case.dart';
import '../../model/enums/case_category.dart';
import '../../model/enums/case_status.dart';

/// Contract for all Case CRUD and lifecycle operations.
abstract interface class CaseService implements Service {
  // ==================== CREATE ====================

  /// Creates a new draft case with generated UUID and formatted case number.
  Future<Case> createCase({
    required String title,
    required CaseCategory category,
    String? description,
    String? plaintiffName,
    String? plaintiffArgument,
    String? defendantName,
    String? defendantArgument,
    String? suggestedCaseId,
  });

  // ==================== READ ====================

  /// Retrieves a case by its unique ID.
  /// Throws [CaseNotFoundException] if not found.
  Future<Case> getCaseById(String id);

  /// Lists all cases with optional filtering and search.
  /// Results are sorted by createdAt descending.
  Future<List<Case>> getAllCases({
    CaseStatus? status,
    CaseCategory? category,
    String? searchQuery,
  });

  /// Counts cases grouped by their status.
  Future<Map<CaseStatus, int>> getCaseCounts();

  // ==================== UPDATE ====================

  /// Updates an existing case.
  /// Throws [CaseAlreadyDecidedException] if case is already decided.
  Future<Case> updateCase(Case updatedCase);

  // ==================== DELETE ====================

  /// Deletes a case and any associated verdict from persistence.
  Future<void> deleteCase(String id);

  // ==================== LIFECYCLE TRANSITIONS ====================

  /// Validates and marks a case as Submitted to court.
  /// Throws [CaseValidationException] if arguments or names are empty.
  Future<Case> submitCase(String id);

  /// Links a finalized verdict to the case and marks status as Decided.
  Future<Case> markCaseDecided(String id, String verdictId);

  // ==================== TEMPLATES ====================

  /// Returns the static curated list of suggested case templates.
  Future<List<SuggestedCase>> getSuggestedCases();
}
```

---

## 4. Case Number Generation Algorithm

Case numbers are generated in the format `TC-YYYY-XXXXX`:
- `TC`: Application identifier ("Tiny Court")
- `YYYY`: Current UTC year (e.g. `2026`)
- `XXXXX`: Sequential 5-digit number stored in preferences (e.g. `00001`, `00042`)
