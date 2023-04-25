part of 'update_sensor_cubit.dart';


class UpdateSensorState extends Equatable {
  final SensorName sensorName;
  final FormzStatus status;
  final String? errorText;

  const UpdateSensorState({
    required this.sensorName,
    required this.status,
    this.errorText,
  });

  factory UpdateSensorState.initial() {
    return const UpdateSensorState(
      sensorName: SensorName.pure(),
      status: FormzStatus.pure,
      errorText: null,
    );
  }

  UpdateSensorState copyWith({
    SensorName? sensorName,
    FormzStatus? status,
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

enum SensorNameValidationError { invalid }

class SensorName extends FormzInput<String, SensorNameValidationError> {
  const SensorName.pure() : super.pure('');

  const SensorName.dirty([String value = '']) : super.dirty(value);

  // static final RegExp _sensorNameRegExp = RegExp(
  //   r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+$',
  // );

  @override
  SensorNameValidationError? validator(String value) {
    return value.isNotEmpty
        ? null
        : SensorNameValidationError.invalid;
  }
}