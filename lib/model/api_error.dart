import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tiny_court/model/serializers.dart';

part 'api_error.g.dart';

abstract class ApiError implements Built<ApiError, ApiErrorBuilder> {
  ApiError._();

  factory ApiError([void Function(ApiErrorBuilder) updates]) = _$ApiError;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ApiError.serializer, this)!
        as Map<String, dynamic>;
  }

  static ApiError fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ApiError.serializer, json)!;
  }

  static Serializer<ApiError> get serializer => _$apiErrorSerializer;

  String? get message;
}
