import '../../domain/entities/sensor.dart';

class SensorModel {
  final int sensorId;
  final String name;
  final int status;
  final int? temperature;
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
      name: json['name'],
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
