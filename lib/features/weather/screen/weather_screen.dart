import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/features/weather/components/error_dialog.dart';
import 'package:flutter_training/features/weather/components/weather.dart';
import 'package:flutter_training/features/weather/exceptions/app_exception.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';
import 'package:flutter_training/features/weather/model/weather_forecast_request.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _yumemiWeather = YumemiWeather();
  WeatherForecast? _weatherForecast;

  final _area = 'tokyo';

  Future<void> _updateWeather() async {
    final request = WeatherForecastRequest(_area);
    final requestJson = jsonEncode(request.toJson());

    try {
      final json = jsonDecode(_yumemiWeather.fetchWeather(requestJson))
          as Map<String, dynamic>;
      final weatherForecast = WeatherForecast.fromJson(json);
      setState(() {
        _weatherForecast = weatherForecast;
      });
    } on YumemiWeatherError catch (e) {
      _showErrorDialog(e.convertErrorMessage());
    } on WeatherConditionException catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              WeatherWidget(weatherForecast: _weatherForecast),
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
