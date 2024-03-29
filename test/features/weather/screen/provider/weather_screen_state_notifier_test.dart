import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:flutter_training/features/weather/screen/provider/weather_screen_state_notifier.dart';
import 'package:flutter_training/features/weather/screen/state/weather_screen_state.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../../mocks/yumemi_weather_repository_mock.mocks.dart';

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
    test('正常系の場合WeatherForecastの値が更新されること', () async {
      // Arrange
      final weatherForecast = WeatherForecast(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 25,
        minTemperature: 7,
        date: DateTime.parse('2020-04-01T12:00:00+09:00'),
      );
      when(mockYumemiWeatherRepository.fetchWeather(any, any))
          .thenAnswer((_) async {
        return weatherForecast;
      });

      // Act
      await container
          .read(weatherScreenStateNotifierProvider.notifier)
          .fetchWeather(area, date);
      final result = container.read(weatherScreenStateNotifierProvider);

      // Assert
      final expected =
          WeatherScreenState(weatherForecast: AsyncData(weatherForecast));

      expect(result, expected);
    });
    group('エラーの場合に意図したエラー文言及びfetch前のstateのWeatherForecastの値が保持されること', () {
      setUp(() async {
        // stateの初期値はnullになるため、weatherForecastのダミー値をセットしておく
        final weatherForecast = WeatherForecast(
          weatherCondition: WeatherCondition.cloudy,
          maxTemperature: 25,
          minTemperature: 7,
          date: DateTime.parse('2020-04-01T12:00:00+09:00'),
        );
        when(mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenAnswer((_) async {
          return weatherForecast;
        });
        await container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
      });
      test('YumemiWeatherErrorの場合', () async {
        // Arrange
        final previousState = container
            .read(weatherScreenStateNotifierProvider.notifier)
            .state
            .weatherForecast;
        const expected = 'APIのエラーが発生しました。';
        when(mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenThrow(YumemiWeatherError.unknown);

        // Act
        await container
            .read(weatherScreenStateNotifierProvider.notifier)
            .fetchWeather(area, date);
        final result = container.read(weatherScreenStateNotifierProvider);
        // Assert
        expect(result.weatherForecast.error, expected);
        expect(result.weatherForecast.value, previousState.value);
      });
      test('Exceptionの場合', () async {
        // Arrange
        final previousState = container
            .read(weatherScreenStateNotifierProvider.notifier)
            .state
            .weatherForecast;
        const expected = '不明なエラーです。';
        when(await mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenThrow(Exception());

        // Act
        await container
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
