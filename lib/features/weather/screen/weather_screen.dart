import 'package:flutter/material.dart';
import 'package:flutter_training/features/weather/components/error_dialog.dart';
import 'package:flutter_training/features/weather/components/weather.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

extension YumemiWeatherErrorExt on YumemiWeatherError {
  String convertErrorMessage() {
    return switch (this) {
      YumemiWeatherError.unknown => 'APIのエラーが発生しました。',
      YumemiWeatherError.invalidParameter => '不正な値が入力されました。'
    };
  }
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _yumemiWeather = YumemiWeather();
  WeatherCondition? _weather;

  final _area = 'tokyo';

  Future<void> _updateWeather() async {
    try {
      final weather =
          WeatherCondition.from(_yumemiWeather.fetchThrowsWeather(_area));
      setState(() {
        _weather = weather;
      });
    } on YumemiWeatherError catch (e) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return ErrorDialogWidget(errorMessage: e.convertErrorMessage());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              WeatherWidget(weather: _weather),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: _updateWeather,
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
    );
  }
}
