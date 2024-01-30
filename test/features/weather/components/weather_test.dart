import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/components/degrees.dart';
import 'package:flutter_training/features/weather/components/weather.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';

import '../utils/display_size.dart';

void main() {
  Future<void> pumpWeatherWidget(
    WidgetTester widgetTester,
    WeatherForecast? weatherForecast,
  ) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: WeatherWidget(
          weatherForecast: weatherForecast,
        ),
      ),
    );
  }

  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    setDisplaySize(binding);
  });
  tearDown(() {
    clearDisplaySize(binding);
  });

  testWidgets('DegreesWidgetが表示されること', (widgetTester) async {
    // Act
    await pumpWeatherWidget(widgetTester, null);
    final finder = find.byType(DegreesWidget);

    // Assert
    expect(finder, findsOneWidget);
  });

  group('SVG表示に関するテスト', () {
    testWidgets('weatherForecastの値がnullの場合、プレースホルダーが表示されること',
        (widgetTester) async {
      // Act
      await pumpWeatherWidget(widgetTester, null);
      final finder = find.byType(Placeholder);

      // Assert
      expect(finder, findsOneWidget);
    });

    group('weatherConditionの値ごとに適切なsvgが表示されること', () {
      final dummyWeatherForecast = WeatherForecast(
        weatherCondition: WeatherCondition.sunny,
        maxTemperature: 1,
        minTemperature: -1,
        date: DateTime.parse(
          '2020-04-01T12:00:00+09:00',
        ),
      );
      for (final weatherCondition in WeatherCondition.values) {
        testWidgets(
            '${weatherCondition.name}の場合assets/${weatherCondition.name}.svgが表示されること',
            (widgetTester) async {
          // Act
          await pumpWeatherWidget(
            widgetTester,
            dummyWeatherForecast.copyWith(
              weatherCondition: weatherCondition,
            ),
          );
          final finder = find.bySemanticsLabel(weatherCondition.name);

          // Assert
          expect(finder, findsOneWidget);
        });
      }
    });
  });
}
