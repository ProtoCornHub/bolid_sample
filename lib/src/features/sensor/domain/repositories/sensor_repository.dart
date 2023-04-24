import 'package:bolid_sample/src/shared/domain/entities/sensor.dart';

abstract class SensorRepository {
  Future<void> addSensor(Sensor sensor);
  Future<List<Sensor>> getSensors();
}