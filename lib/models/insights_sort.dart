import 'package:flutter/cupertino.dart';

class InsightsSort extends ChangeNotifier {
  String sortType = 'all';
  void changeSortType(String type) {
    sortType = type;
    notifyListeners();
  }
  String get currentSortType => sortType;
}