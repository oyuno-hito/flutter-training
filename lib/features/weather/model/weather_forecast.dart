import 'dart:convert';

import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast.g.dart';
part 'weather_forecast.freezed.dart';

@freezed
class WeatherForecast with _$WeatherForecast {
  const factory WeatherForecast({
    required WeatherCondition weatherCondition,
    required int maxTemperature,
    required int minTemperature,
    required DateTime date,
  }) = _WeatherForecast;

  factory WeatherForecast.fromJson(Map<String, Object?> json) =>
      _$WeatherForecastFromJson(json);

  factory WeatherForecast.fromJsonString(String json) {
    final decodedJson = jsonDecode(json) as Map<String, Object?>?;
    if (decodedJson == null) {
      throw const FormatException('サーバーから不正な値が返されました。');
    }
    return WeatherForecast.fromJson(decodedJson);
  }
}
