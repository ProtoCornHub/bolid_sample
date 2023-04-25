import 'package:bolid_sample/src/features/sensor/domain/repositories/sensor_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../shared/domain/entities/sensor.dart';
import '../../../../shared/domain/use_cases/use_cases.dart';

class UpdateSensor implements UseCase<void, UpdateSensorParams> {
  final SensorRepository sensorRepository;

  UpdateSensor(this.sensorRepository);
  @override
  Future<void> call(UpdateSensorParams params) {
    return sensorRepository.updateSensor(params.sensor);
  }
}

class UpdateSensorParams extends Equatable {
  final Sensor sensor;

  const UpdateSensorParams({required this.sensor});

  @override
  List<Object?> get props => [sensor];
}
