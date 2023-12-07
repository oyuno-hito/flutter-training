import 'package:flutter_training/features/weather/exceptions/app_exception.dart';

enum WeatherCondition {
  sunny(image: 'assets/sunny.svg'),
  cloudy(image: 'assets/cloudy.svg'),
  rainy(image: 'assets/rainy.svg'),
  ;

  const WeatherCondition({required this.image});

  factory WeatherCondition.from(String name) =>
      WeatherCondition.values.singleWhere(
        (element) => element.name == name,
        orElse: () => throw const WeatherConditionException(),
      );

  final String image;
}
