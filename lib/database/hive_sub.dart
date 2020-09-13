import 'package:hive/hive.dart';

part 'hive_sub.g.dart';

@HiveType(typeId: 1, adapterName: 'SubDataAdapter')
class SubData {
  @HiveField(0)
  final String dateFormat;

  SubData({
    this.dateFormat,
  });
}
