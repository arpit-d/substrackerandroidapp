import 'package:hive/hive.dart';

part 'hive_sub.g.dart';

@HiveType(typeId: 1, adapterName: 'SubDataAdapter')
class SubData {
  @HiveField(0)
  final double allExp;
  @HiveField(1)
  final double paidExp;
  @HiveField(2)
  final double unpaidExp;
  @HiveField(3)
  final bool darkMode;
  @HiveField(4)
  final int count;
  @HiveField(5)
  final int paidcount;
  @HiveField(6)
  final int unpaidcount;

  SubData({
    this.allExp,
    this.paidExp,
    this.unpaidExp,
    this.darkMode,
    this.count,
    this.paidcount,
    this.unpaidcount
  });
}
 