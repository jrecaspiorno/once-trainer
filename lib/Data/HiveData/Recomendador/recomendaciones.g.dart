// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recomendaciones.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecomendacioneAdapter extends TypeAdapter<Recomendacione> {
  @override
  final typeId = 0;

  @override
  Recomendacione read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recomendacione(
      (fields[0] as Map)?.cast<String, dynamic>(),
      fields[1] as String,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Recomendacione obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.grupo)
      ..writeByte(2)
      ..write(obj.fecha);
  }
}
