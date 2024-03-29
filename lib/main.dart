import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/features/splash/screen/splash_screen.dart';
import 'package:flutter_training/features/weather/screen/weather_screen.dart';
import 'package:flutter_training/routes.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.splash.path: (context) => const SplashScreen(),
        Routes.weather.path: (context) => const WeatherScreen(),
      },
      initialRoute: Routes.splash.path,
    );
  }
}
