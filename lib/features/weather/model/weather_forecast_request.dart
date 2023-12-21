import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast_request.g.dart';
part 'weather_forecast_request.freezed.dart';

@freezed
class WeatherForecastRequest with _$WeatherForecastRequest {
  const factory WeatherForecastRequest(
    String area,
    DateTime date,
  ) = _WeatherForecastRequest;

  factory WeatherForecastRequest.fromJson(Map<String, Object?> json) =>
      _$WeatherForecastRequestFromJson(json);
}
