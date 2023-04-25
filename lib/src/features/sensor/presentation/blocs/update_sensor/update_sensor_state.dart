part of 'update_sensor_cubit.dart';

enum UpdateSensorStatus { initial, loading, success, error }

class UpdateSensorState extends Equatable {
  final String sensorName;
  final UpdateSensorStatus status;
  final String? errorText;

  const UpdateSensorState({
    required this.sensorName,
    required this.status,
    this.errorText,
  });

  factory UpdateSensorState.initial() {
    return const UpdateSensorState(
      sensorName: '',
      status: UpdateSensorStatus.initial,
      errorText: null,
    );
  }

  UpdateSensorState copyWith({
    String? sensorName,
    UpdateSensorStatus? status,
    String? errorText,
  }) {
    return UpdateSensorState(
      sensorName: sensorName ?? this.sensorName,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [sensorName, errorText, status];
}
