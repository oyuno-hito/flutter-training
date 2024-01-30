import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/components/degrees.dart';
import 'package:flutter_training/features/weather/components/weather.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';

import '../utils/display_size.dart';
import 'utils/svg_image_assertion.dart';

void main() {
  Future<void> pumpWidget(
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
    await pumpWidget(widgetTester, null);
    final finder = find.byType(DegreesWidget);

    // Assert
    expect(finder, findsOneWidget);
  });

  group('SVG表示に関するテスト', () {
    testWidgets('weatherForecastの値がnullの場合、プレースホルダーが表示されること',
        (widgetTester) async {
      // Act
      await pumpWidget(widgetTester, null);
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
      testWidgets('sunnyの場合assets/sunny.svgが表示されること', (widgetTester) async {
        // Act
        await pumpWidget(
          widgetTester,
          dummyWeatherForecast,
        );
        final finder = find.bySemanticsLabel(WeatherCondition.sunny.name);

        // Assert
        expect(finder, findsOneWidget);
      });
      testWidgets('cloudyの場合assets/cloudy.svgが表示されること', (widgetTester) async {
        // Act
        await pumpWidget(
          widgetTester,
          dummyWeatherForecast.copyWith(
            weatherCondition: WeatherCondition.cloudy,
          ),
        );
        final finder = find.bySemanticsLabel(WeatherCondition.cloudy.name);

        // Assert
        expect(finder, findsOneWidget);
      });
      testWidgets('rainyの場合assets/rainy.svgが表示されること', (widgetTester) async {
        // Act
        await pumpWidget(
          widgetTester,
          dummyWeatherForecast.copyWith(
            weatherCondition: WeatherCondition.rainy,
          ),
        );
        final finder = find.bySemanticsLabel(WeatherCondition.rainy.name);

        // Assert
        expect(finder, findsOneWidget);
      });
    });
  });
}
