import 'package:flutter/material.dart';
import 'package:flutter_training/models/weather_condition.dart';
import 'package:flutter_training/widgets/weather/weather.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _yumemiWeather = YumemiWeather();
  WeatherCondition? _weather;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            onPressed: () {},
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
      ),
    );
  }
}
