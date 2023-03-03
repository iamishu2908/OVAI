// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calories_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalorieDataAdapter extends TypeAdapter<CalorieData> {
  @override
  final int typeId = 0;

  @override
  CalorieData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalorieData(
      day: fields[0] as String,
      value: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CalorieData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalorieDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
