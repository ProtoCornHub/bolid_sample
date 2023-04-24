// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SensorModelAdapter extends TypeAdapter<SensorModel> {
  @override
  final int typeId = 0;

  @override
  SensorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SensorModel(
      sensorId: fields[0] as int,
      name: fields[1] as String,
      status: fields[2] as int,
      temperature: fields[3] as int?,
      humidity: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SensorModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sensorId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.temperature)
      ..writeByte(4)
      ..write(obj.humidity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SensorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
