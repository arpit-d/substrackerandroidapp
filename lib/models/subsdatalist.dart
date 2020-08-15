import 'package:substracker/database/new_sub.dart';

class SubsDataList {
  List<Sub> subsList = List();
  void setSubList(List<Sub> s) {
    subsList = s;
  }
  List<Sub> get listData => subsList;
}