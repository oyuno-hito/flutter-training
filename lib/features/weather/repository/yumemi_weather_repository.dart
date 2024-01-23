import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/model/weather_forecast_request.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class YumemiWeatherRepository {
  const YumemiWeatherRepository(
    YumemiWeather yumemiWeather,
  ) : _yumemiWeather = yumemiWeather;

  final YumemiWeather _yumemiWeather;

  WeatherForecast fetchWeather(String area, DateTime date) {
    final requestString = WeatherForecastRequest(
      area,
      date,
    ).toJsonString();

    final responseString = _yumemiWeather.fetchWeather(requestString);
    return WeatherForecast.fromJsonString(responseString);
  }
}
