import 'package:flutter_training/features/weather/model/weather_condition.dart';

class WeatherForecast {
  const WeatherForecast({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final weatherCondition =
        WeatherCondition.values.from(json['weather_condition'].toString());

    if (weatherCondition == null) {
      throw const FormatException('サーバーから不正な値が返されました。');
    }

    final maxTemperature = int.tryParse(json['max_temperature'].toString());
    if (maxTemperature == null) {
      throw const FormatException('サーバーから不正な値が返されました。');
    }

    final minTemperature = int.tryParse(json['min_temperature'].toString());
    if (minTemperature == null) {
      throw const FormatException('サーバーから不正な値が返されました。');
    }

    final date = DateTime.tryParse(json['date'].toString());
    if (date == null) {
      throw const FormatException('サーバーから不正な値が返されました。');
    }

    return WeatherForecast(
      weatherCondition: weatherCondition,
      maxTemperature: maxTemperature,
      minTemperature: minTemperature,
      date: date,
    );
  }

  final WeatherCondition weatherCondition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
