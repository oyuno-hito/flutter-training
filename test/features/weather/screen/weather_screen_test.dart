import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/components/degrees.dart';
import 'package:flutter_training/features/weather/components/error_dialog.dart';
import 'package:flutter_training/features/weather/components/weather.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_repository_provider.dart';
import 'package:flutter_training/features/weather/screen/weather_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../mocks/navigator_observer_mock.mocks.dart';
import '../../../mocks/yumemi_weather_repository_mock.mocks.dart';
import '../utils/display_size.dart';

void main() {
  final mockNavigatorObserver = MockNavigatorObserver();
  final mockYumemiWeatherRepository = MockYumemiWeatherRepository();
  Future<void> pumpWeatherScreen(
    WidgetTester widgetTester, {
    List<Override> overrides = const [],
  }) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        // NOTE: Repositoryのモックが不要なテストではモックしない
        overrides: overrides,
        child: MaterialApp(
          home: const WeatherScreen(),
          navigatorObservers: [mockNavigatorObserver],
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

  testWidgets('各種widgetが表示されること(WeatherWidget, Closeボタン, Reloadボタン)',
      (widgetTester) async {
    // Arrange
    await pumpWeatherScreen(widgetTester);
    final weatherWidgetFinder = find.byType(WeatherWidget);
    final closeKeyFinder = find.byKey(WeatherScreen.closeKey);
    final reloadKeyFinder = find.byKey(WeatherScreen.reloadKey);

    // Assert
    expect(weatherWidgetFinder, findsOneWidget);
    expect(closeKeyFinder, findsOneWidget);
    expect(reloadKeyFinder, findsOneWidget);
  });

  testWidgets('Closeボタンを押下したとき、WeatherScreenWidgetがpopされること',
      (widgetTester) async {
    // Arrange
    await pumpWeatherScreen(widgetTester);
    final closedButtonFinder = find.byKey(WeatherScreen.closeKey);

    // Act
    await widgetTester.tap(closedButtonFinder);
    await widgetTester.pump();

    // Assert
    verify(mockNavigatorObserver.didPop(any, any)).called(1);
  });

  group('Reloadボタン押下時、', () {
    final dummyWeatherForecast = WeatherForecast(
      weatherCondition: WeatherCondition.sunny,
      maxTemperature: 1,
      minTemperature: -1,
      date: DateTime.parse(
        '2020-04-01T12:00:00+09:00',
      ),
    );
    testWidgets('weatherForecastが更新される場合WeatherWidgetの値が更新されること',
        (widgetTester) async {
      // Arrange
      await pumpWeatherScreen(
        widgetTester,
        overrides: [
          yumemiWeatherRepositoryProvider
              .overrideWithValue(mockYumemiWeatherRepository),
        ],
      );
      when(mockYumemiWeatherRepository.fetchWeather(any, any))
          .thenAnswer((_) async {
        return dummyWeatherForecast;
      });

      final reloadFinder = find.byKey(WeatherScreen.reloadKey);

      // Act
      await widgetTester.tap(reloadFinder);
      await widgetTester.pump();

      // Assert

      // NOTE: WeatherForecastのstateが更新されている検証の代表値として
      //       アクセス・検証が容易なmaxTemperatureを利用
      final maxTemperature = find
          .byKey(DegreesWidget.maxTemperatureKey)
          .evaluate()
          .singleOrNull
          ?.widget as Text?;

      expect(maxTemperature?.data, '1 ℃');
    });

    testWidgets(
      'エラー発生時エラーダイアログが表示され、WeatherWidgetの値が更新されないこと',
      (widgetTester) async {
        // Arrange
        await pumpWeatherScreen(
          widgetTester,
          overrides: [
            yumemiWeatherRepositoryProvider
                .overrideWithValue(mockYumemiWeatherRepository),
          ],
        );
        final reloadFinder = find.byKey(WeatherScreen.reloadKey);

        // NOTE: 事前準備としてWeatherScreenStateの値を入れておく
        when(mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenAnswer((_) async {
          return dummyWeatherForecast;
        });
        await widgetTester.tap(reloadFinder);
        await widgetTester.pump();

        when(mockYumemiWeatherRepository.fetchWeather(any, any))
            .thenThrow(YumemiWeatherError.unknown);

        // Act
        await widgetTester.tap(reloadFinder);
        await widgetTester.pump();

        // Assert
        final errorDialogFinder = find.byType(ErrorDialogWidget);
        expect(errorDialogFinder, findsOneWidget);

        // NOTE: WeatherForecastのstateの代表値として
        //       アクセス・検証が容易なmaxTemperatureを利用
        final maxTemperature = find
            .byKey(DegreesWidget.maxTemperatureKey)
            .evaluate()
            .singleOrNull
            ?.widget as Text?;

        expect(maxTemperature?.data, '1 ℃');
      },
    );
  });
}
