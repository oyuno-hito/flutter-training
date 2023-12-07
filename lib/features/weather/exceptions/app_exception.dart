import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherConditionException implements Exception {
  const WeatherConditionException();
  @override
  String toString() {
    return '不正なAPIレスポンスが返されました';
  }
}

extension YumemiWeatherErrorExt on YumemiWeatherError {
  String convertErrorMessage() {
    return switch (this) {
      YumemiWeatherError.unknown => 'APIのエラーが発生しました。',
      YumemiWeatherError.invalidParameter => '不正な値が入力されました。'
    };
  }
}
