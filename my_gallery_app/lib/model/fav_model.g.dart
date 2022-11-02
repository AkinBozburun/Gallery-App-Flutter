// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavsAdapter extends TypeAdapter<Favs> {
  @override
  final int typeId = 0;

  @override
  Favs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favs()
      ..favID = fields[0] as int
      ..favName = fields[1] as String
      ..favInfo = fields[2] as String
      ..favImage = fields[3] as String
      ..favImageOriginal = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Favs obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.favID)
      ..writeByte(1)
      ..write(obj.favName)
      ..writeByte(2)
      ..write(obj.favInfo)
      ..writeByte(3)
      ..write(obj.favImage)
      ..writeByte(4)
      ..write(obj.favImageOriginal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
