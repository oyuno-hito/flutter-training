import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_provider.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'yumemi_weather_repository_test.mocks.dart';

@GenerateMocks([YumemiWeather])
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

    test('YumemiWeatherがJsonを返す場合シリアライズされたWeatherForecastが返ること', () {
      // Arrange
      const weatherForecast = '''
        {
          "weather_condition":"cloudy",
          "max_temperature":25,
          "min_temperature":7,
          "date":"2020-04-01T12:00:00+09:00"
          }
        ''';
      when(mockYumemiWeather.fetchWeather(any)).thenReturn(weatherForecast);

      // Act
      final result = container
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
      when(mockYumemiWeather.fetchWeather(any))
          .thenThrow(YumemiWeatherError.unknown);

      // Assert
      expect(
        () => container
            .read(yumemiWeatherRepositoryProvider)
            .fetchWeather(area, date),
        throwsA(YumemiWeatherError.unknown),
      );
    });
  });
}
