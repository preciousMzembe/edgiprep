// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigAdapter extends TypeAdapter<Config> {
  @override
  final int typeId = 7;

  @override
  Config read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Config(
      apiUrl: fields[0] as String,
      privacyPolicyUrl: fields[1] as String,
      appUrl: fields[2] as String,
      quizQuestions: fields[3] as int,
      topicQuizQuestions: fields[4] as int,
      premiumPrice: fields[5] as String,
      subjectsImageUrl: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.apiUrl)
      ..writeByte(1)
      ..write(obj.privacyPolicyUrl)
      ..writeByte(2)
      ..write(obj.appUrl)
      ..writeByte(3)
      ..write(obj.quizQuestions)
      ..writeByte(4)
      ..write(obj.topicQuizQuestions)
      ..writeByte(5)
      ..write(obj.premiumPrice)
      ..writeByte(6)
      ..write(obj.subjectsImageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
