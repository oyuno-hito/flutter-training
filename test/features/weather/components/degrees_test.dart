import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/components/degrees.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester widgetTester,
    DegreesWidget degreesWidget,
  ) async {
    await widgetTester.pumpWidget(
      MaterialApp(home: degreesWidget),
    );
  }

  testWidgets('temperatureの値がint型の時、minTemperature, maxTemperatureがそれぞれ表示されること',
      (widgetTester) async {
    // Arrange
    await pumpWidget(
      widgetTester,
      const DegreesWidget(
        maxTemperature: 1,
        minTemperature: -1,
      ),
    );

    final maxTemperature = find
        .byKey(DegreesWidget.maxTemperatureKey)
        .evaluate()
        .singleOrNull
        ?.widget as Text?;

    final minTemperature = find
        .byKey(DegreesWidget.minTemperatureKey)
        .evaluate()
        .singleOrNull
        ?.widget as Text?;

    // Assert
    expect(maxTemperature?.data, '1 ℃');
    expect(maxTemperature?.style?.color, Colors.red);

    expect(minTemperature?.data, '-1 ℃');
    expect(minTemperature?.style?.color, Colors.blue);
  });

  testWidgets('temperatureの値がnullの時、プレースホルダーの値が表示されること', (widgetTester) async {
    // Arrange
    await pumpWidget(
      widgetTester,
      const DegreesWidget(),
    );

    final defalutTemperatureFinder = find.text('** ℃');

    // Assert
    expect(defalutTemperatureFinder, findsNWidgets(2));
  });
}
