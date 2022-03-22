import 'package:eps_hisoft/models/project.dart';
import 'package:flutter/material.dart';

class SelectProjectController extends ChangeNotifier {
  Project? project;
  bool hasError = false;

  void setValue(Project? d) {
    project = d;
    hasError = false;
    notifyListeners();
  }

  void setHasError(bool e) {
    hasError = e;
    if (e) {
      notifyListeners();
    } else {
      project = null;
    }
  }

  void verify() {
    if (project == null) {
      setHasError(true);
      throw Exception();
    }
  }
}
