// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecomList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecomListAdapter extends TypeAdapter<RecomList> {
  @override
  final typeId = 1;

  @override
  RecomList read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecomList(
      fields[1] as String,
      (fields[0] as List)?.cast<String>(),
      fields[3] as int,
      fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecomList obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.tipo)
      ..writeByte(0)
      ..write(obj.ejercicios)
      ..writeByte(3)
      ..write(obj.hechosLista)
      ..writeByte(4)
      ..write(obj.hechosTotales);
  }
}
