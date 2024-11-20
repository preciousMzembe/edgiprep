// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_paper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PastPaperAdapter extends TypeAdapter<PastPaper> {
  @override
  final int typeId = 6;

  @override
  PastPaper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PastPaper(
      id: fields[0] as String,
      name: fields[1] as String,
      duration: fields[2] as String,
      questions: fields[3] as int,
      subjectId: fields[4] as String,
      score: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PastPaper obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.questions)
      ..writeByte(4)
      ..write(obj.subjectId)
      ..writeByte(5)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PastPaperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
