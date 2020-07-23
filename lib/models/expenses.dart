import 'package:flutter/cupertino.dart';

class Expenses with ChangeNotifier {
  double exp;
  void setExpenses(double e) async {
    await Future.delayed(const Duration(milliseconds: 10), () {});
    exp = e;
    notifyListeners();
  }

  double get expenses => exp;
}
