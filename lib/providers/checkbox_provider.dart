import 'package:flutter/material.dart';

class CheckBoxProvider extends ChangeNotifier {
  bool _isFreeEbookSelected = false;

  bool? get isFreeEbookSelected => _isFreeEbookSelected;

  void onCheckboxChanged(bool value) {
    _isFreeEbookSelected = value;
    notifyListeners();
  }
}
