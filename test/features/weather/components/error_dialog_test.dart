import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/features/weather/components/error_dialog.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/navigator_observer_mock.mocks.dart';
import '../utils/display_size.dart';

void main() {
  const dummyErrorMessage = 'dummy';
  final mockNavigatorObserver = MockNavigatorObserver();
  Future<void> pumpWidget(
    WidgetTester widgetTester,
  ) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: const ErrorDialogWidget(
          errorMessage: dummyErrorMessage,
        ),
        navigatorObservers: [mockNavigatorObserver],
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

  testWidgets('AlertDialogWidgetが表示され、引数で与えられたエラーメッセージテキストが表示されること',
      (widgetTester) async {
    // Act
    await pumpWidget(widgetTester);

    // Assert
    final alertDialogFinder = find.byType(AlertDialog);
    expect(alertDialogFinder, findsOneWidget);

    final alertDialogTextFinder = find.byType(Text);
    final errorMessageText = find
        .descendant(of: alertDialogFinder, matching: alertDialogTextFinder)
        .evaluate()
        .firstOrNull
        ?.widget as Text?;

    expect(errorMessageText?.data, dummyErrorMessage);
  });
  testWidgets('AlertDialogWidget内のボタンをタップすることでErrorDialogWidgetがpopされること',
      (widgetTester) async {
    // Arrange
    await pumpWidget(widgetTester);

    // Act
    final okButtonFinder = find.byKey(ErrorDialogWidget.okButtonKey);
    await widgetTester.tap(okButtonFinder);
    await widgetTester.pumpAndSettle();

    // Assert
    verify(mockNavigatorObserver.didPop(any, any)).called(1);
  });
}
