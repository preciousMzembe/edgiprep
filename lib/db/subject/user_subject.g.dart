// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSubjectAdapter extends TypeAdapter<UserSubject> {
  @override
  final int typeId = 9;

  @override
  UserSubject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSubject(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      color: fields[3] as String,
      icon: fields[4] as String,
      image: fields[5] as String,
      examId: fields[6] as String,
      numberOfTopics: fields[7] as int,
      numberOfTopicsDone: fields[8] as int,
      currentTopic: fields[9] as String,
      enrollmentId: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserSubject obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.examId)
      ..writeByte(7)
      ..write(obj.numberOfTopics)
      ..writeByte(8)
      ..write(obj.numberOfTopicsDone)
      ..writeByte(9)
      ..write(obj.currentTopic)
      ..writeByte(10)
      ..write(obj.enrollmentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
