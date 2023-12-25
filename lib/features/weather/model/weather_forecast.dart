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
    final maxTemperature = int.tryParse(json['max_temperature'].toString());
    final minTemperature = int.tryParse(json['min_temperature'].toString());
    final date = DateTime.tryParse(json['date'].toString());

    if (weatherCondition == null ||
        maxTemperature == null ||
        minTemperature == null ||
        date == null) {
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
