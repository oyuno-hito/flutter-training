// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_forecast_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeatherForecastRequest _$WeatherForecastRequestFromJson(
    Map<String, dynamic> json) {
  return _WeatherForecastRequest.fromJson(json);
}

/// @nodoc
mixin _$WeatherForecastRequest {
  String get area => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherForecastRequestCopyWith<WeatherForecastRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherForecastRequestCopyWith<$Res> {
  factory $WeatherForecastRequestCopyWith(WeatherForecastRequest value,
          $Res Function(WeatherForecastRequest) then) =
      _$WeatherForecastRequestCopyWithImpl<$Res, WeatherForecastRequest>;
  @useResult
  $Res call({String area, DateTime date});
}

/// @nodoc
class _$WeatherForecastRequestCopyWithImpl<$Res,
        $Val extends WeatherForecastRequest>
    implements $WeatherForecastRequestCopyWith<$Res> {
  _$WeatherForecastRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherForecastRequestImplCopyWith<$Res>
    implements $WeatherForecastRequestCopyWith<$Res> {
  factory _$$WeatherForecastRequestImplCopyWith(
          _$WeatherForecastRequestImpl value,
          $Res Function(_$WeatherForecastRequestImpl) then) =
      __$$WeatherForecastRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String area, DateTime date});
}

/// @nodoc
class __$$WeatherForecastRequestImplCopyWithImpl<$Res>
    extends _$WeatherForecastRequestCopyWithImpl<$Res,
        _$WeatherForecastRequestImpl>
    implements _$$WeatherForecastRequestImplCopyWith<$Res> {
  __$$WeatherForecastRequestImplCopyWithImpl(
      _$WeatherForecastRequestImpl _value,
      $Res Function(_$WeatherForecastRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? date = null,
  }) {
    return _then(_$WeatherForecastRequestImpl(
      null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherForecastRequestImpl extends _WeatherForecastRequest {
  const _$WeatherForecastRequestImpl(this.area, this.date) : super._();

  factory _$WeatherForecastRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherForecastRequestImplFromJson(json);

  @override
  final String area;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'WeatherForecastRequest(area: $area, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherForecastRequestImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherForecastRequestImplCopyWith<_$WeatherForecastRequestImpl>
      get copyWith => __$$WeatherForecastRequestImplCopyWithImpl<
          _$WeatherForecastRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherForecastRequestImplToJson(
      this,
    );
  }
}

abstract class _WeatherForecastRequest extends WeatherForecastRequest {
  const factory _WeatherForecastRequest(
      final String area, final DateTime date) = _$WeatherForecastRequestImpl;
  const _WeatherForecastRequest._() : super._();

  factory _WeatherForecastRequest.fromJson(Map<String, dynamic> json) =
      _$WeatherForecastRequestImpl.fromJson;

  @override
  String get area;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$WeatherForecastRequestImplCopyWith<_$WeatherForecastRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
