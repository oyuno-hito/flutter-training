import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'weather_screen_state.g.dart';
part 'weather_screen_state.freezed.dart';

@freezed
class WeatherScreenState with _$WeatherScreenState {
  const factory WeatherScreenState({
    required WeatherForecast? weatherForecast,
    required String? errorMessage,
  }) = _WeatherScreenState;

  static const init =
      WeatherScreenState(weatherForecast: null, errorMessage: null);
}
