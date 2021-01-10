import 'package:flutter/cupertino.dart';

class Expenses with ChangeNotifier {
  double _exp;
  void setExpenses(double e) async {
    await Future.delayed(const Duration(milliseconds: 10), () {});
    _exp = e;
    notifyListeners();
  }

  double get expenses => _exp;
}
