class WeatherForecastRequest {
  WeatherForecastRequest(
    this.area,
  );

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'date': '2020-04-01T12:00:00+09:00',
    };
  }

  final String area;
}
