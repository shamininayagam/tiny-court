import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder)? updates]) = _$AppState;

  AppState._();

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(AppState.serializer, this)
        as Map<String, dynamic>?;
  }

  static AppState? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AppState.serializer, json);
  }

  static Serializer<AppState> get serializer => _$appStateSerializer;

  static void _initializeBuilder(AppStateBuilder b) {
    b.count = 0;
  }

  int? get count;
}
