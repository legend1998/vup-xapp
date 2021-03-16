// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Coupans.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoupanAdapter extends TypeAdapter<Coupan> {
  @override
  final int typeId = 5;

  @override
  Coupan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coupan(
      usedBy: fields[0] as String,
      id: fields[1] as String,
      coupanCode: fields[2] as String,
      v: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Coupan obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.usedBy)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.coupanCode)
      ..writeByte(3)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoupanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
