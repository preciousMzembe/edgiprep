// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectProgressAdapter extends TypeAdapter<SubjectProgress> {
  @override
  final int typeId = 12;

  @override
  SubjectProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectProgress(
      subjectEnrollmentId: fields[0] as String,
      completedLessons: fields[1] as int,
      totalLessons: fields[2] as int,
      totalTopics: fields[3] as int,
      coveredTopics: fields[4] as int,
      completedQuizzes: fields[5] as int,
      completedMocks: fields[6] as int,
      completedPPs: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectProgress obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.subjectEnrollmentId)
      ..writeByte(1)
      ..write(obj.completedLessons)
      ..writeByte(2)
      ..write(obj.totalLessons)
      ..writeByte(3)
      ..write(obj.totalTopics)
      ..writeByte(4)
      ..write(obj.coveredTopics)
      ..writeByte(5)
      ..write(obj.completedQuizzes)
      ..writeByte(6)
      ..write(obj.completedMocks)
      ..writeByte(7)
      ..write(obj.completedPPs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
