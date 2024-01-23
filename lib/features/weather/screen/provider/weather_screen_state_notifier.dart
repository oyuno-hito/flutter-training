import 'package:flutter_training/features/weather/exceptions/app_exception.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:flutter_training/features/weather/screen/state/weather_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_screen_state_notifier.g.dart';

@riverpod
class WeatherScreenStateNotifier extends _$WeatherScreenStateNotifier {
  @override
  WeatherScreenState build() {
    return const WeatherScreenState(weatherForecast: AsyncData(null));
  }

  void fetchWeather(String area, DateTime date) {
    final previousState = state.weatherForecast;
    try {
      final newForecast =
          ref.read(yumemiWeatherRepositoryProvider).fetchWeather(area, date);
      state = state.copyWith(weatherForecast: AsyncData(newForecast));
    } on YumemiWeatherError catch (e, s) {
      final message = e.convertErrorMessage();
      state = state.copyWith(
        weatherForecast: AsyncError<WeatherForecast?>(message, s)
            .copyWithPrevious(previousState),
      );
    } on Exception catch (_, s) {
      const message = '不明なエラーです。';
      state = state.copyWith(
        weatherForecast: AsyncError<WeatherForecast?>(message, s)
            .copyWithPrevious(previousState),
      );
    }
  }
}
