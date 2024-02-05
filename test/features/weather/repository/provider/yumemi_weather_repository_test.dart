import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_provider.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../../mocks/yumemi_weather_mock.mocks.dart';

void main() {
  group('fetchWeather', () {
    late ProviderContainer container;
    final mockYumemiWeather = MockYumemiWeather();

    const area = 'tokyo';
    final date = DateTime.parse('2020-04-01T12:00:00+09:00');

    setUp(() {
      container = ProviderContainer(
        overrides: [
          yumemiWeatherProvider.overrideWithValue(mockYumemiWeather),
        ],
      );
    });
    tearDown(() {
      container.dispose();
    });

    test('YumemiWeatherがJsonを返す場合シリアライズされたWeatherForecastが返ること', () async {
      // Arrange
      const weatherForecast = '''
        {
          "weather_condition":"cloudy",
          "max_temperature":25,
          "min_temperature":7,
          "date":"2020-04-01T12:00:00+09:00"
          }
        ''';
      when(mockYumemiWeather.syncFetchWeather(any)).thenReturn(weatherForecast);

      // Act
      final result = await container
          .read(yumemiWeatherRepositoryProvider)
          .fetchWeather(area, date);

      // Assert
      final expected = WeatherForecast(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 25,
        minTemperature: 7,
        date: DateTime.parse('2020-04-01T12:00:00+09:00'),
      );
      expect(result, expected);
    });
    test('YumemiWeatherがunknownエラーを返す場合、例外としてYumemiWeatherError.unknownが返ること',
        () {
      // Arrange
      when(mockYumemiWeather.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.unknown);

      // Act・Assert
      expect(
        () async {
          await container
              .read(yumemiWeatherRepositoryProvider)
              .fetchWeather(area, date);
        },
        throwsA(YumemiWeatherError.unknown),
      );
    });
  });
}
