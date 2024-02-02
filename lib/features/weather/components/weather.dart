import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/features/weather/components/degrees.dart';
import 'package:flutter_training/features/weather/model/weather_forecast.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    WeatherForecast? weatherForecast,
  }) : _weatherForecast = weatherForecast;

  final WeatherForecast? _weatherForecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: _weatherForecast == null
              ? const Placeholder()
              : SvgPicture.asset(
                  _weatherForecast.weatherCondition.image,
                  semanticsLabel: _weatherForecast.weatherCondition.name,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: DegreesWidget(
            maxTemperature: _weatherForecast?.maxTemperature,
            minTemperature: _weatherForecast?.minTemperature,
          ),
        ),
      ],
    );
  }
}
