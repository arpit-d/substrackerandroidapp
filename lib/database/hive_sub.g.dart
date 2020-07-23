// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_sub.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubDataAdapter extends TypeAdapter<SubData> {
  @override
  final typeId = 1;
  @override
  SubData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubData(
      allExp: fields[0] as double,
      paidExp: fields[1] as double,
      unpaidExp: fields[2] as double,
      darkMode: fields[3] as bool,
      count: fields[4] as int,
      paidcount: fields[5] as int,
      unpaidcount: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.allExp)
      ..writeByte(1)
      ..write(obj.paidExp)
      ..writeByte(2)
      ..write(obj.unpaidExp)
      ..writeByte(3)
      ..write(obj.darkMode)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.paidcount)
      ..writeByte(6)
      ..write(obj.unpaidcount);
  }
}
