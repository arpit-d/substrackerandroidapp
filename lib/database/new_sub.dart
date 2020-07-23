import 'dart:async';

import 'dart:core';
import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'new_sub.g.dart';

class Subs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get subsName => text().withLength(min: 1, max: 30)();

  RealColumn get subsPrice => real()();

  TextColumn get notes => text().nullable().withLength(max: 100)();

  TextColumn get payStatus => text()();

  TextColumn get payMethod => text().nullable()();

  DateTimeColumn get payDate => dateTime()();

  TextColumn get periodNo => text()();

  TextColumn get periodType => text()();

  TextColumn get category => text().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Subs])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  Stream<List<Sub>> getSubs() => select(subs).watch();

  // insert a sub
  Future insertSub(Sub sub) => into(subs).insert(sub);
  // update a sub
  Future updateSub(Sub sub) => update(subs).replace(sub);
  // delete a sub
  Future deleteTask(Sub sub) => delete(subs).delete(sub);
  // get all subs whose payment status equals paid
  Stream<List<Sub>> getPaidSubs() {
    return (select(subs)..where((s) => s.payStatus.equals('Paid'))).watch();
  }

  Stream<List<Sub>> getPendingSubs() {
    return (select(subs)..where((s) => s.payStatus.equals('Pending'))).watch();
  }

  Stream<List<Sub>> getAscSubs() {
    return (select(subs)
          ..orderBy(
            ([
              (s) =>
                  OrderingTerm(expression: s.subsName, mode: OrderingMode.asc),
            ]),
          ))
        .watch();
  }

  Stream<List<Sub>> getDescSubs() {
    return (select(subs)
          ..orderBy(
            ([
              (s) =>
                  OrderingTerm(expression: s.subsName, mode: OrderingMode.desc),
            ]),
          ))
        .watch();
  }

  @override
  int get schemaVersion => 1;
}
