import 'package:flutter/material.dart';

class DateFormatChanger with ChangeNotifier {
  String dateFormat = 'dd/MM/yy';

  void setDateFormat(String dF) {
    dateFormat = dF;
    notifyListeners();
  }
  String get dateFormatType => dateFormat;
}