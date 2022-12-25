// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tadarus_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TadarusAdapter extends TypeAdapter<Tadarus> {
  @override
  final int typeId = 0;

  @override
  Tadarus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tadarus(
      timestamps: fields[0] as String,
      surah_name: fields[1] as String,
      surah_number: fields[2] as int,
      ayah_number: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Tadarus obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timestamps)
      ..writeByte(1)
      ..write(obj.surah_name)
      ..writeByte(2)
      ..write(obj.surah_number)
      ..writeByte(3)
      ..write(obj.ayah_number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TadarusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
