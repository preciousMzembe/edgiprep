// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_xps.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserXpsAdapter extends TypeAdapter<UserXps> {
  @override
  final int typeId = 14;

  @override
  UserXps read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserXps(
      id: fields[0] as int,
      xps: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserXps obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.xps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserXpsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
