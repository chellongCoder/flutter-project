import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Helper {
  static final brightness =
      SchedulerBinding.instance!.window.platformBrightness;
  final bool isDark = brightness == Brightness.dark;
}
