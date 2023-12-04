import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> nextPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!context.mounted) {
      return;
    }
    await Navigator.pushNamed(context, Routes.weather.path);
    unawaited(nextPage());
  }

  @override
  void initState() {
    super.initState();
    unawaited(
      WidgetsBinding.instance.endOfFrame.then((_) {
        nextPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
