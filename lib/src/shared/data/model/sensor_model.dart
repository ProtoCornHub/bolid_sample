import 'package:hive/hive.dart';

import '../../domain/entities/sensor.dart';

part 'sensor_model.g.dart';

@HiveType(typeId: 0)
class SensorModel {
  @HiveField(0)
  final int sensorId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int status;
  @HiveField(3)
  final int? temperature;
  @HiveField(4)
  final int? humidity;

  SensorModel({
    required this.sensorId,
    required this.name,
    required this.status,
    this.temperature,
    this.humidity,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      sensorId: json['sensor_id'],
      name: json['name'].toString().isEmpty ? '[Empty]' : json['name'],
      status: json['status'],
      temperature: json['temperature'],
      humidity: json['humidity'],
    );
  }

  factory SensorModel.fromEntity(Sensor sensor) {
    return SensorModel(
      sensorId: sensor.sensorId,
      name: sensor.name,
      status: sensor.status,
      temperature: sensor.temperature,
      humidity: sensor.humidity,
    );
  }

  Sensor toEntity() {
    return Sensor(
      sensorId: sensorId,
      name: name,
      status: status,
      temperature: temperature,
      humidity: humidity,
    );
  }
}
