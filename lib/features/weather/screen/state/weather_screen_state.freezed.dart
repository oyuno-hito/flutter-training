// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeatherScreenState {
  AsyncValue<WeatherForecast?> get weatherForecast =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherScreenStateCopyWith<WeatherScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherScreenStateCopyWith<$Res> {
  factory $WeatherScreenStateCopyWith(
          WeatherScreenState value, $Res Function(WeatherScreenState) then) =
      _$WeatherScreenStateCopyWithImpl<$Res, WeatherScreenState>;
  @useResult
  $Res call({AsyncValue<WeatherForecast?> weatherForecast});
}

/// @nodoc
class _$WeatherScreenStateCopyWithImpl<$Res, $Val extends WeatherScreenState>
    implements $WeatherScreenStateCopyWith<$Res> {
  _$WeatherScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherForecast = null,
  }) {
    return _then(_value.copyWith(
      weatherForecast: null == weatherForecast
          ? _value.weatherForecast
          : weatherForecast // ignore: cast_nullable_to_non_nullable
              as AsyncValue<WeatherForecast?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherScreenStateImplCopyWith<$Res>
    implements $WeatherScreenStateCopyWith<$Res> {
  factory _$$WeatherScreenStateImplCopyWith(_$WeatherScreenStateImpl value,
          $Res Function(_$WeatherScreenStateImpl) then) =
      __$$WeatherScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<WeatherForecast?> weatherForecast});
}

/// @nodoc
class __$$WeatherScreenStateImplCopyWithImpl<$Res>
    extends _$WeatherScreenStateCopyWithImpl<$Res, _$WeatherScreenStateImpl>
    implements _$$WeatherScreenStateImplCopyWith<$Res> {
  __$$WeatherScreenStateImplCopyWithImpl(_$WeatherScreenStateImpl _value,
      $Res Function(_$WeatherScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherForecast = null,
  }) {
    return _then(_$WeatherScreenStateImpl(
      weatherForecast: null == weatherForecast
          ? _value.weatherForecast
          : weatherForecast // ignore: cast_nullable_to_non_nullable
              as AsyncValue<WeatherForecast?>,
    ));
  }
}

/// @nodoc

class _$WeatherScreenStateImpl implements _WeatherScreenState {
  const _$WeatherScreenStateImpl({required this.weatherForecast});

  @override
  final AsyncValue<WeatherForecast?> weatherForecast;

  @override
  String toString() {
    return 'WeatherScreenState(weatherForecast: $weatherForecast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherScreenStateImpl &&
            (identical(other.weatherForecast, weatherForecast) ||
                other.weatherForecast == weatherForecast));
  }

  @override
  int get hashCode => Object.hash(runtimeType, weatherForecast);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherScreenStateImplCopyWith<_$WeatherScreenStateImpl> get copyWith =>
      __$$WeatherScreenStateImplCopyWithImpl<_$WeatherScreenStateImpl>(
          this, _$identity);
}

abstract class _WeatherScreenState implements WeatherScreenState {
  const factory _WeatherScreenState(
          {required final AsyncValue<WeatherForecast?> weatherForecast}) =
      _$WeatherScreenStateImpl;

  @override
  AsyncValue<WeatherForecast?> get weatherForecast;
  @override
  @JsonKey(ignore: true)
  _$$WeatherScreenStateImplCopyWith<_$WeatherScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
