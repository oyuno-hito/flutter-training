import 'package:yumemi_weather/yumemi_weather.dart';

extension YumemiWeatherErrorExt on YumemiWeatherError {
  String convertErrorMessage() {
    return switch (this) {
      YumemiWeatherError.unknown => 'APIのエラーが発生しました。',
      YumemiWeatherError.invalidParameter => '不正な値が入力されました。'
    };
  }
}
