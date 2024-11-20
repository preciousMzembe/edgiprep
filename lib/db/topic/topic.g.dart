// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopicAdapter extends TypeAdapter<Topic> {
  @override
  final int typeId = 4;

  @override
  Topic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Topic(
      id: fields[0] as String,
      name: fields[1] as String,
      order: fields[2] as int,
      unitId: fields[3] as String,
      numberOfLessons: fields[4] as int,
      numberOfLessonsDone: fields[5] as int,
      needSubscrion: fields[6] as bool,
      active: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Topic obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.order)
      ..writeByte(3)
      ..write(obj.unitId)
      ..writeByte(4)
      ..write(obj.numberOfLessons)
      ..writeByte(5)
      ..write(obj.numberOfLessonsDone)
      ..writeByte(6)
      ..write(obj.needSubscrion)
      ..writeByte(7)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
