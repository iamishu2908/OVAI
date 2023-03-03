// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predict_pcod_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassPredictPcodAdapter extends TypeAdapter<ClassPredictPcod> {
  @override
  final int typeId = 1;

  @override
  ClassPredictPcod read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassPredictPcod(
      fields[0] as bool,
      fields[1] as bool,
      fields[2] as bool,
      fields[3] as bool,
      fields[4] as bool,
      fields[5] as bool,
      fields[6] as bool,
      fields[7] as bool,
      fields[9] as int,
      fields[10] as int,
      fields[11] as int,
      fields[12] as int,
      fields[13] as int,
      fields[14] as int,
      fields[15] as int,
      fields[16] as int,
      fields[8] as bool,
      fields[17] as DateTime?,
      fields[18] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ClassPredictPcod obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.fast_food)
      ..writeByte(1)
      ..write(obj.pregnant)
      ..writeByte(2)
      ..write(obj.weight_gain)
      ..writeByte(3)
      ..write(obj.hair_growth)
      ..writeByte(4)
      ..write(obj.hair_fall)
      ..writeByte(5)
      ..write(obj.pimples)
      ..writeByte(6)
      ..write(obj.exercise)
      ..writeByte(7)
      ..write(obj.darkening_skin)
      ..writeByte(8)
      ..write(obj.predict_PCOD)
      ..writeByte(9)
      ..write(obj.pulse)
      ..writeByte(10)
      ..write(obj.respiration)
      ..writeByte(11)
      ..write(obj.cycle_length)
      ..writeByte(12)
      ..write(obj.marriage)
      ..writeByte(13)
      ..write(obj.hipsize)
      ..writeByte(14)
      ..write(obj.waistsize)
      ..writeByte(15)
      ..write(obj.cycleRI)
      ..writeByte(16)
      ..write(obj.abortion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassPredictPcodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
