class WeatherForecastRequest {
  WeatherForecastRequest(
    this.area,
    this.date,
  );

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'date': date.toIso8601String(),
    };
  }

  final String area;
  final DateTime date;
}
