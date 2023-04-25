import 'package:bolid_sample/src/shared/domain/entities/sensor.dart';

abstract class SensorRepository {
  Future<List<Sensor>> getSensors();
  Future<void> updateSensor(Sensor sensor);
}