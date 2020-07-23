import 'package:flutter/cupertino.dart';

class Sort with ChangeNotifier {
  String sort = 'all';
  void changeSort(String s) {
    if (s == 'Paid') {
      sort = s;
    } else if (s == 'Pending') {
      sort = 'Pending';
    } else if (s == 'Asc') {
      sort = 'Asc';
    } else if (s == 'Desc') {
      sort = 'Desc';
    } else if (s == 'Upcoming') {
      sort = 'Upcoming';
    } else {
      sort = 'all';
    }
    notifyListeners();
  }

  String get sorts => sort;
}
