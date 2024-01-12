import 'package:flutter_training/features/weather/repository/provider/yumemi_weather_provider.dart';
import 'package:flutter_training/features/weather/repository/yumemi_weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'yumemi_weather_repository_provider.g.dart';

@riverpod
YumemiWeatherRepository yumemiWeatherRepository(
  YumemiWeatherRepositoryRef ref,
) =>
    YumemiWeatherRepository(ref.watch(yumemiWeatherProvider));
