import 'package:flutter/foundation.dart';

class IsClickedProvider extends ChangeNotifier {
  bool _value = false;

  bool get value => _value;

  void setValue(bool newValue) {
    _value = newValue;
    notifyListeners();
  }
}
