import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:flutter_training/features/weather/repository/yumemi_weather_repository.dart';
import 'package:flutter_training/features/weather/screen/provider/weather_screen_state_notifier.dart';
import 'package:flutter_training/features/weather/screen/state/weather_screen_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_screen_state_notifier_test.mocks.dart';

@GenerateMocks([YumemiWeatherRepository])
void main() {
  group('fetchWeather', () {
    const area = 'tokyo';
    final date = DateTime.parse('2020-04-01T12:00:00+09:00');

    late ProviderContainer container;
    final mockYumemiWeatherRepository = MockYumemiWeatherRepository();

    setUp(() {
      container = ProviderContainer(
        overrides: [
          yumemiWeatherRepositoryProvider.overrideWithValue(
            mockYumemiWeatherRepository,
          ),
        ],
      );
    });
    tearDown(() {
      container.dispose();
    });
    test('正常系の場合WeatherForecastの値が更新されること', () {
      // Arrange
      final weatherForecast = WeatherForecast(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 25,
        minTemperature: 7,
        date: DateTime.parse('2020-04-01T12:00:00+09:00'),
      );
      when(mockYumemiWeatherRepository.fetchWeather(any, any))
          .thenReturn(weatherForecast);

      // Act
      container
          .read(weatherScreenStateNotifierProvider.notifier)
          .fetchWeather(area, date);
      final result = container.read(weatherScreenStateNotifierProvider);

      // Assert
      final expected =
          WeatherScreenState(weatherForecast: AsyncData(weatherForecast));

      expect(result, expected);
    });
    group('エラーの場合に意図したエラー文言及びfetch前のstateのWeatherForecastの値が保持されること', () {
      setUp(() {
        final weatherForecast = WeatherForecast(
          weatherCondition: WeatherCondition.cloudy,
          maxTemperature: 25,
          minTemperature: 7,
          date: DateTime.parse('2020-04-01T12:00:00+09:00'),
        );
        when(mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenReturn(weatherForecast);
        container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
      });
      test('YumemiWeatherErrorの場合', () {
        // Arrange
        final previousState = container
            .read(weatherScreenStateNotifierProvider.notifier)
            .state
            .weatherForecast;
        const expected = 'APIのエラーが発生しました。';
        when(mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenThrow(YumemiWeatherError.unknown);

        // Act
        container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
        final result = container.read(weatherScreenStateNotifierProvider);

        // Assert
        expect(result.weatherForecast.error, expected);
        expect(result.weatherForecast.value, previousState.value);
      });
      test('Exceptionの場合', () {
        // Arrange
        final previousState = container
            .read(weatherScreenStateNotifierProvider.notifier)
            .state
            .weatherForecast;
        const expected = '不明なエラーです。';
        when(mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenThrow(Exception());

        // Act
        container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
        final result = container.read(weatherScreenStateNotifierProvider);

        // Assert
        expect(result.weatherForecast.error, expected);
        expect(result.weatherForecast.value, previousState.value);
      });
    });
  });
}
