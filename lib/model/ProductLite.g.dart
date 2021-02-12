// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductLite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductLiteAdapter extends TypeAdapter<ProductLite> {
  @override
  final int typeId = 2;

  @override
  ProductLite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductLite(
      category: (fields[0] as List)?.cast<String>(),
      createdAt: fields[1] as DateTime,
      featured: fields[2] as bool,
      id: fields[3] as String,
      title: fields[4] as String,
      offerPrice: fields[5] as int,
      sellPrice: fields[6] as int,
      description: fields[7] as String,
      color: fields[8] as String,
      thumbnailUrl: fields[9] as String,
      group: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductLite obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.featured)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.offerPrice)
      ..writeByte(6)
      ..write(obj.sellPrice)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.thumbnailUrl)
      ..writeByte(10)
      ..write(obj.group);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductLiteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
