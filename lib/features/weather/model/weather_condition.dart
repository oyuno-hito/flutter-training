enum WeatherCondition {
  sunny(image: 'assets/sunny.svg'),
  cloudy(image: 'assets/cloudy.svg'),
  rainy(image: 'assets/rainy.svg'),
  ;

  const WeatherCondition({required this.image});

  factory WeatherCondition.from(String name) =>
      WeatherCondition.values.singleWhere(
        (element) => element.name == name,
        orElse: () => throw Exception('`$name` is invalid value'),
      );

  final String image;
}
