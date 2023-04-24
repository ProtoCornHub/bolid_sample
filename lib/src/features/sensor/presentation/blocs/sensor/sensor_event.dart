part of 'sensor_bloc.dart';

abstract class SensorEvent extends Equatable {
  const SensorEvent();
}

class SensorGetSensors extends SensorEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}