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
      imagesUrl: fields[1] as String,
      privacyPolicyUrl: fields[2] as String,
      appUrl: fields[3] as String,
      quizQuestions: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.apiUrl)
      ..writeByte(1)
      ..write(obj.imagesUrl)
      ..writeByte(2)
      ..write(obj.privacyPolicyUrl)
      ..writeByte(3)
      ..write(obj.appUrl)
      ..writeByte(4)
      ..write(obj.quizQuestions);
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
