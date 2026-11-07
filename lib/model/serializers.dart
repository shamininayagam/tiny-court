import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'api_error.dart';
import 'app_settings.dart';
import 'app_state.dart';
import 'case.dart';
import 'enums/case_category.dart';
import 'enums/case_status.dart';
import 'enums/verdict_type.dart';
import 'suggested_case.dart';
import 'verdict.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  AppState,
  ApiError,
  CaseCategory,
  CaseStatus,
  VerdictType,
  Case,
  Verdict,
  SuggestedCase,
  AppSettings,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
