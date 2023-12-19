import 'package:collection/collection.dart';

enum WeatherCondition {
  sunny(image: 'assets/sunny.svg'),
  cloudy(image: 'assets/cloudy.svg'),
  rainy(image: 'assets/rainy.svg'),
  ;

  const WeatherCondition({required this.image});

  final String image;
}

extension WeatherConditionExt on Iterable<WeatherCondition> {
  WeatherCondition? from(String name) {
    return firstWhereOrNull((element) => element.name == name);
  }
}
