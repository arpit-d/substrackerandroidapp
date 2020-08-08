import 'package:flutter/cupertino.dart';

class Filter with ChangeNotifier {
  String filter;
  void changeFilter(String f) {
    filter = f;
    notifyListeners();
  }

  String get getFilter => filter;
}
