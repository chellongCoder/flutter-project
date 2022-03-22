import 'package:eps_hisoft/models/project.dart';
import 'package:eps_hisoft/models/ship.dart';
import 'package:flutter/material.dart';

class SelectShipController extends ChangeNotifier {
  Ship? ship;
  bool hasError = false;

  void setValue(Ship? d) {
    ship = d;
    hasError = false;
    notifyListeners();
  }

  void setHasError(bool e) {
    hasError = e;
    if (e) {
      notifyListeners();
    } else {
      ship = null;
    }
  }

  void verify() {
    if (ship == null) {
      setHasError(true);
      throw Exception();
    }
  }
}
