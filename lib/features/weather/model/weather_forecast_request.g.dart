// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'weather_forecast_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherForecastRequestImpl _$$WeatherForecastRequestImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$WeatherForecastRequestImpl',
      json,
      ($checkedConvert) {
        final val = _$WeatherForecastRequestImpl(
          $checkedConvert('area', (v) => v as String),
          $checkedConvert('date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$WeatherForecastRequestImplToJson(
        _$WeatherForecastRequestImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date.toIso8601String(),
    };
