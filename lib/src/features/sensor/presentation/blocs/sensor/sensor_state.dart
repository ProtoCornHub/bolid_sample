part of 'sensor_bloc.dart';

abstract class SensorState extends Equatable {
  const SensorState();
}

class SensorLoading extends SensorState {
  @override
  List<Object> get props => [];
}

class SensorLoaded extends SensorState {
  final List<Sensor> sensors;

  const SensorLoaded({this.sensors = const <Sensor>[]});
  @override
  List<Object> get props => [sensors];
}

class SensorFailure extends SensorState {
  final String message;

  const SensorFailure({required this.message});

  @override
  List<Object> get props => [message];
}
