import 'package:equatable/equatable.dart';

class Sensor extends Equatable {
  final int sensorId;
  final String name;
  final int status;
  final int? temperature;
  final int? humidity;

  const Sensor({
    required this.sensorId,
    required this.name,
    required this.status,
    this.temperature,
    this.humidity,
  });

  static const empty = Sensor(
    sensorId: 17,
    name: "Office",
    status: 1,
    temperature: 21,
    humidity: 35,
  );

  Sensor copyWith({
    int? sensorId,
    String? name,
    int? status,
    int? temperature,
    int? humidity,
  }) {
    return Sensor(
      sensorId: sensorId ?? this.sensorId,
      name: name ?? this.name,
      status: status ?? this.status,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
    );
  }

  @override
  List<Object?> get props => [
        sensorId,
        name,
        status,
        temperature,
        humidity,
      ];
}
