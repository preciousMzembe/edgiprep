// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_exam.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserExamAdapter extends TypeAdapter<UserExam> {
  @override
  final int typeId = 8;

  @override
  UserExam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserExam(
      id: fields[0] as String,
      title: fields[1] as String,
      selected: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserExam obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserExamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
