// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 4;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      dateJoined: fields[0] as DateTime,
      address: (fields[1] as List)?.cast<dynamic>(),
      role: fields[2] as String,
      cart: (fields[3] as List)?.cast<dynamic>(),
      wishlist: (fields[4] as List)?.cast<dynamic>(),
      orders: (fields[5] as List)?.cast<dynamic>(),
      id: fields[6] as String,
      uid: fields[7] as String,
      fname: fields[8] as String,
      lname: fields[9] as String,
      email: fields[10] as String,
      password: fields[11] as String,
      phone: fields[12] as String,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      v: fields[15] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.dateJoined)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.cart)
      ..writeByte(4)
      ..write(obj.wishlist)
      ..writeByte(5)
      ..write(obj.orders)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.uid)
      ..writeByte(8)
      ..write(obj.fname)
      ..writeByte(9)
      ..write(obj.lname)
      ..writeByte(10)
      ..write(obj.email)
      ..writeByte(11)
      ..write(obj.password)
      ..writeByte(12)
      ..write(obj.phone)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
