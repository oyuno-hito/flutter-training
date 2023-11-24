import 'package:flutter/material.dart';
import 'package:flutter_training/widget/navigator/navigator.dart';
import 'package:flutter_training/widget/weather/weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body:  Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(
              children: [
                Spacer(),
                WeatherWidget(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: NavigatorWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
