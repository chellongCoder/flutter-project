import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class Helper {
  static final brightness =
      SchedulerBinding.instance!.window.platformBrightness;
  final bool isDark = brightness == Brightness.dark;

  static DateTime formatToDate(String dateString) {
    var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return inputFormat.parse(dateString);
  }

  static String formatDateToString(DateTime date) {
    var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return inputFormat.format(date);
  }

  static String formatDateToStringNoHour(DateTime date) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    return inputFormat.format(date);
  }

  static String getDateStringWithDash(DateTime date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    return inputFormat.format(date);
  }

  static String getDateStringFirstMonth() {
    var inputFormat = DateFormat('yyyy-MM-dd');
    return inputFormat
        .format(DateTime(DateTime.now().year, DateTime.now().month, 1));
  }

  static String getDateStringLastMonth() {
    var inputFormat = DateFormat('yyyy-MM-dd');
    return inputFormat
        .format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0));
  }

  static String getTextTime(TimeOfDay time) {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }
}
