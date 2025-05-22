// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchResultAdapter extends TypeAdapter<SearchResult> {
  @override
  final int typeId = 17;

  @override
  SearchResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchResult(
      type: fields[0] as String,
      subject: fields[1] as UserSubject?,
      topic: fields[2] as Topic?,
    );
  }

  @override
  void write(BinaryWriter writer, SearchResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.topic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
