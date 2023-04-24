import 'package:bolid_sample/src/shared/domain/entities/sensor.dart';
import 'package:bolid_sample/src/shared/domain/use_cases/use_cases.dart';

import '../repositories/sensor_repository.dart';

class GetSensors implements UseCase<List<Sensor>, NoParams> {
  final SensorRepository sensorRepository;

  GetSensors(this.sensorRepository);

  @override
  Future<List<Sensor>> call(NoParams params) {
    return sensorRepository.getSensors();
  }
}
