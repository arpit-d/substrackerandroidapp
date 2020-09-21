import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

getRealDate(
    DateTime d, String pNo, String pType, bool sortType, String dateFormat) {
  DateTime realDays;
  if (pType == 'Day') {
    realDays = Jiffy(d).add(days: int.parse(pNo));
  } else if (pType == 'Week') {
    realDays = Jiffy(d).add(weeks: int.parse(pNo));
  } else if (pType == 'Year') {
    realDays = Jiffy(d).add(years: int.parse(pNo));
  } else {
    realDays = Jiffy(d).add(months: int.parse(pNo));
  }
  while (realDays.isBefore(DateTime.now())) {
    if (pType == 'Day') {
      realDays = Jiffy(realDays).add(days: int.parse(pNo));
    } else if (pType == 'Week') {
      realDays = Jiffy(realDays).add(weeks: int.parse(pNo));
    } else if (pType == 'Year') {
      realDays = Jiffy(realDays).add(years: int.parse(pNo));
    } else {
      realDays = Jiffy(realDays).add(months: int.parse(pNo));
    }
  }
  if (sortType == true) {
    return realDays;
  }

  var r = 'Next Payment: ' + DateFormat(dateFormat).format(realDays);
  return r.toString();
}
