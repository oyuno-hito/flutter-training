import 'package:flutter_training/features/weather/exceptions/app_exception.dart';
import 'package:flutter_training/features/weather/model/weather_screen_state.dart';
import 'package:flutter_training/features/weather/provider/repository/yumemi_weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_screen_state_notifier.g.dart';

@riverpod
class WeatherScreenStateNotifier extends _$WeatherScreenStateNotifier {
  final YumemiWeatherRepository _yumemiWeatherRepository =
      YumemiWeatherRepository(YumemiWeather());

  @override
  WeatherScreenState build() {
    return WeatherScreenState.init;
  }

  void fetchWeather() {
    try {
      final newForecast =
          _yumemiWeatherRepository.fetchWeather('tokyo', DateTime.now());
      state = state.copyWith(weatherForecast: newForecast);
    } on YumemiWeatherError catch (e) {
      state = state.copyWith(errorMessage: e.convertErrorMessage());
      return;
    } on Exception catch (_) {
      const message = '不明なエラーです。';
      state = state.copyWith(errorMessage: message);
      return;
    }
  }

  void errorMessageShown() {
    state = state.copyWith(errorMessage: null);
  }
}
