// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonAdapter extends TypeAdapter<Lesson> {
  @override
  final int typeId = 5;

  @override
  Lesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lesson(
      id: fields[0] as String,
      name: fields[1] as String,
      order: fields[2] as int,
      topicId: fields[3] as String,
      numberOfSlides: fields[4] as int,
      numberOfSlidesDone: fields[5] as int,
      active: fields[6] as bool,
      lessonNumber: fields[7] as int,
      isFirst: fields[8] as bool,
      isLast: fields[9] as bool,
      subjectEnrollmentId: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Lesson obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.order)
      ..writeByte(3)
      ..write(obj.topicId)
      ..writeByte(4)
      ..write(obj.numberOfSlides)
      ..writeByte(5)
      ..write(obj.numberOfSlidesDone)
      ..writeByte(6)
      ..write(obj.active)
      ..writeByte(7)
      ..write(obj.lessonNumber)
      ..writeByte(8)
      ..write(obj.isFirst)
      ..writeByte(9)
      ..write(obj.isLast)
      ..writeByte(10)
      ..write(obj.subjectEnrollmentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
