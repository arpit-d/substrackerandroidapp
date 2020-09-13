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
      dateFormat: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dateFormat);
  }
}
