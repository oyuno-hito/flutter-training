import 'package:flutter/material.dart';
import 'package:flutter_training/widget/weather/degrees.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Placeholder(),
          ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: DegreesWidget(),
        ),
      ],
    );
  }
}
