import '../../domain/entities/event.dart';

class EventModel {
  final int sensorId;
  final String name;
  final int status;
  final int? temperature;
  final int? humidity;

  EventModel({
    required this.sensorId,
    required this.name,
    required this.status,
    this.temperature,
    this.humidity,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      sensorId: json['sensor_id'],
      name: json['name'],
      status: json['status'],
      temperature: json['temperature'],
      humidity: json['humidity'],
    );
  }

  factory EventModel.fromEntity(Event event) {
    return EventModel(
      sensorId: event.sensorId,
      name: event.name,
      status: event.status,
      temperature: event.temperature,
      humidity: event.humidity,
    );
  }

  Event toEntity() {
    return Event(
      sensorId: sensorId,
      name: name,
      status: status,
      temperature: temperature,
      humidity: humidity,
    );
  }
}
