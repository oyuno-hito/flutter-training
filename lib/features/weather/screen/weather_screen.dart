import 'package:flutter/material.dart';
import 'package:flutter_training/features/weather/components/weather.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _yumemiWeather = YumemiWeather();
  WeatherCondition? _weather;

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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            final weather = WeatherCondition.from(
                              _yumemiWeather.fetchSimpleWeather(),
                            );
                            setState(() {
                              _weather = weather;
                            });
                          },
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
