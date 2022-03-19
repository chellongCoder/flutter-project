import 'package:flutter/material.dart';

class SelectDateController extends ChangeNotifier {
  DateTime? date;

  void setValue(DateTime? d) {
    date = d;
    notifyListeners();
  }
}
