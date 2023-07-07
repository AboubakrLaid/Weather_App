import 'package:flutter/material.dart';

class Refresh extends ChangeNotifier {
  bool isEditing = false; // for manage location body to enable
  // sorting other locations

  List<bool> selectedLocationList = [];
  refresh() {
    notifyListeners();
  }
}
