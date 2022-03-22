import 'package:flutter/material.dart';

class SelectTimeController extends ChangeNotifier {
  TimeOfDay? time;

  void setValue(TimeOfDay? d) {
    time = d;
    notifyListeners();
  }
}
