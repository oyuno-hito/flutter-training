import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/features/weather/components/degrees.dart';
import 'package:flutter_training/features/weather/model/weather_condition.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    WeatherCondition? weather,
  }) : _weather = weather;

  final WeatherCondition? _weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: _weather == null
              ? const Placeholder()
              : SvgPicture.asset(_weather.image),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: DegreesWidget(),
        ),
      ],
    );
  }
}
