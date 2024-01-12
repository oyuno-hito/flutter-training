import 'package:flutter_training/features/weather/exceptions/app_exception.dart';
import 'package:flutter_training/features/weather/model/weather_screen_state.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_screen_state_notifier.g.dart';

@riverpod
class WeatherScreenStateNotifier extends _$WeatherScreenStateNotifier {
  @override
  WeatherScreenState build() {
    return WeatherScreenState.init;
  }

  void fetchWeather(String area, DateTime date) {
    try {
      final newForecast =
          ref.read(yumemiWeatherRepositoryProvider).fetchWeather(area, date);
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
