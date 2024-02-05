import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/features/weather/components/error_dialog.dart';
import 'package:flutter_training/features/weather/components/weather.dart';
import 'package:flutter_training/features/weather/screen/provider/weather_screen_state_notifier.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @visibleForTesting
  static final closeKey = UniqueKey();

  @visibleForTesting
  static final reloadKey = UniqueKey();

  // NOTE: ダイアログのデフォルトの背景色を適用
  static const dialogColor = Colors.black54;

  void _showErrorDialog(String message, BuildContext context) {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return ErrorDialogWidget(errorMessage: message);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(weatherScreenStateNotifierProvider, (_, weatherScreenState) {
      if (weatherScreenState.weatherForecast is! AsyncError) {
        return;
      }
      final errorMessage = weatherScreenState.weatherForecast.error.toString();
      _showErrorDialog(errorMessage, context);
    });
    const area = 'tokyo';
    final date = DateTime.now();
    final weatherForecast =
        ref.watch(weatherScreenStateNotifierProvider).weatherForecast;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: AbsorbPointer(
                absorbing: weatherForecast.isLoading,
                child: Column(
                  children: [
                    const Spacer(),
                    WeatherWidget(weatherForecast: weatherForecast.value),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                key: closeKey,
                                child: const Text('Close'),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () => unawaited(
                                  ref
                                      .read(
                                        weatherScreenStateNotifierProvider
                                            .notifier,
                                      )
                                      .fetchWeather(area, date),
                                ),
                                key: reloadKey,
                                child: const Text('Reload'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (weatherForecast.isLoading)
            const ColoredBox(
              color: dialogColor,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
