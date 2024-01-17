import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/model/weather_screen_state.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:flutter_training/features/weather/repository/yumemi_weather_repository.dart';
import 'package:flutter_training/features/weather/screen/provider/weather_screen_state_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_screen_state_notifier_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  group('fetchWeather', () {
    const area = 'tokyo';
    final date = DateTime.parse('2020-04-01T12:00:00+09:00');

    late ProviderContainer container;
    final mockYumemiWeather = MockYumemiWeather();

    setUp(() {
      container = ProviderContainer(
        overrides: [
          yumemiWeatherRepositoryProvider.overrideWithValue(
            YumemiWeatherRepository(mockYumemiWeather),
          ),
        ],
      );
    });
    tearDown(() {
      container.dispose();
    });
    test('正常系の場合WeatherForecastの値が更新されること', () {
      const weatherForecast = '''
        {
          "weather_condition":"cloudy",
          "max_temperature":25,
          "min_temperature":7,
          "date":"2020-04-01T12:00:00+09:00"
          }
        ''';
      final expected = WeatherScreenState(
        weatherForecast: AsyncData(
          WeatherForecast(
            weatherCondition: WeatherCondition.cloudy,
            maxTemperature: 25,
            minTemperature: 7,
            date: DateTime.parse('2020-04-01T12:00:00+09:00'),
          ),
        ),
      );
      when(mockYumemiWeather.fetchWeather(any)).thenReturn(weatherForecast);
      container
          .read(weatherScreenStateNotifierProvider.notifier)
          .fetchWeather(area, date);
      final result = container.read(weatherScreenStateNotifierProvider);
      expect(result, expected);
    });
    group('エラーの場合に意図したエラー文言及びfetch前のstateのWeatherForecastの値が保持されること', () {
      setUp(() {
        const previousStateJson = '''
        {
          "weather_condition":"cloudy",
          "max_temperature":25,
          "min_temperature":7,
          "date":"2020-04-01T12:00:00+09:00"
          }
        ''';
        when(mockYumemiWeather.fetchWeather(any)).thenReturn(previousStateJson);
        container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
      });
      test('YumemiWeatherErrorの場合', () {
        final previousState = container
            .read(weatherScreenStateNotifierProvider.notifier)
            .state
            .weatherForecast;
        const expected = 'APIのエラーが発生しました。';
        when(mockYumemiWeather.fetchWeather(any))
            .thenThrow(YumemiWeatherError.unknown);
        container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
        final result = container.read(weatherScreenStateNotifierProvider);
        expect(result.weatherForecast.error, expected);
        expect(result.weatherForecast.value, previousState.value);
      });
      test('Exceptionの場合', () {
        final previousState = container
            .read(weatherScreenStateNotifierProvider.notifier)
            .state
            .weatherForecast;
        const expected = '不明なエラーです。';
        when(mockYumemiWeather.fetchWeather(any)).thenThrow(Exception());
        container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
        final result = container.read(weatherScreenStateNotifierProvider);
        expect(result.weatherForecast.error, expected);
        expect(result.weatherForecast.value, previousState.value);
      });
    });
  });
}
