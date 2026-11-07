import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'case_category.g.dart';

/// Strongly-typed BuiltValue EnumClass representing dispute categories.
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
