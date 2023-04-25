import 'package:bolid_sample/src/shared/domain/entities/sensor.dart';

abstract class SensorRepository {
  // Get sensors form data layer
  Future<List<Sensor>> getSensors();
  // Put sensor to data layer
  Future<void> updateSensor(Sensor sensor);
}