// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'done_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonemodelAdapter extends TypeAdapter<Donemodel> {
  @override
  final int typeId = 2;

  @override
  Donemodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Donemodel(
      isChecked: fields[4] as bool,
      title: fields[0] as String,
      desc: fields[1] as String,
      dateTime: fields[2] as DateTime,
      type: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Donemodel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonemodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
