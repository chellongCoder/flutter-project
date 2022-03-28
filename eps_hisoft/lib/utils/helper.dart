import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class Helper {
  static final brightness =
      SchedulerBinding.instance!.window.platformBrightness;
  final bool isDark = brightness == Brightness.dark;

  static String formatToDateTimeZone(DateTime date) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return inputFormat.format(date) + "Z";
  }

  static String formatTimeZoneToString(String timeZone) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    return formatDateToString(inputFormat.parse(timeZone));
  }

  static DateTime formatTimeZoneToDate(String dateString) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    return inputFormat.parse(dateString);
  }

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

  static DateTime formatStringToDateNoHour(String dateString) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    return inputFormat.parse(dateString);
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
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return '$hours:$minutes';
  }

  static void showError(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    ));
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
