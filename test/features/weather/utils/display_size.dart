import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

void setDisplaySize(TestWidgetsFlutterBinding binding) {
  binding.platformDispatcher.implicitView!.physicalSize =
      const Size(1080, 1920);
  binding.platformDispatcher.implicitView!.devicePixelRatio = 1;
}

void clearDisplaySize(TestWidgetsFlutterBinding binding) {
  binding.platformDispatcher.implicitView!.resetPhysicalSize();
  binding.platformDispatcher.implicitView!.resetDevicePixelRatio();
}
