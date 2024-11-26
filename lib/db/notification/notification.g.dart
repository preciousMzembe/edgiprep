// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNotificationAdapter extends TypeAdapter<UserNotification> {
  @override
  final int typeId = 11;

  @override
  UserNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNotification(
      title: fields[0] as String,
      message: fields[1] as String,
      seen: fields[2] as bool,
      time: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserNotification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.seen)
      ..writeByte(3)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
