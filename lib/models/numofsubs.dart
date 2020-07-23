
import 'package:flutter/cupertino.dart';

class NumOfSubs with ChangeNotifier {
  int numOfSubs = 0;
  void totalSubs(int s) async {
    await Future.delayed(const Duration(milliseconds: 10), () {});
    numOfSubs = s;
    notifyListeners();
  }

  int get nm => numOfSubs;
}

