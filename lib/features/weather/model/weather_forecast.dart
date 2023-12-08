import 'package:flutter_training/features/weather/model/weather_condition.dart';

class WeatherForecast {
  const WeatherForecast({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      weatherCondition:
          WeatherCondition.from(json['weather_condition'] as String),
      maxTemperature: json['max_temperature'] as int,
      minTemperature: json['min_temperature'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  final WeatherCondition weatherCondition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
