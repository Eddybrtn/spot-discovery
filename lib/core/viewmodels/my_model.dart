import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  String myVariable = "Test";

  void updateMyVariable(String newText) {
    myVariable = newText;
    notifyListeners();
  }
}
