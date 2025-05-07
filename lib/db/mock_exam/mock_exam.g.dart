// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_exam.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MockExamAdapter extends TypeAdapter<MockExam> {
  @override
  final int typeId = 13;

  @override
  MockExam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MockExam(
      id: fields[0] as String,
      name: fields[1] as String,
      questions: fields[2] as int,
      subjectId: fields[3] as String,
      duration: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MockExam obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.questions)
      ..writeByte(3)
      ..write(obj.subjectId)
      ..writeByte(4)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MockExamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
