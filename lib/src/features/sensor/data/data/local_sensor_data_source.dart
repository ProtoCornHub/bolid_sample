import 'package:hive/hive.dart';
import '../../../../shared/data/model/sensor_model.dart';
import '../../../../shared/domain/entities/sensor.dart';

abstract class LocalSensorDataSource {
  Future<void> addSensor(Sensor sensor);
  Future<List<Sensor>> getSensors();
  Future<void> updateSensor(Sensor sensor);
}

class LocalSensorDataSourceImpl implements LocalSensorDataSource {
  // Create a box collection
  Future<Box> _openSensorBox() async {
    return Hive.openBox<SensorModel>('sensors');
  }

  // Put sensor in collection
  @override
  Future<void> addSensor(Sensor sensor) async {
    Box box = await _openSensorBox();
    await box.put(sensor.sensorId, SensorModel.fromEntity(sensor));
  }

  // Get list of sensors
  @override
  Future<List<Sensor>> getSensors() async {
    Box<SensorModel> box = await _openSensorBox() as Box<SensorModel>;
    return box.values.toList().map((user) => user.toEntity()).toList();
  }

  // Update sensor with sensor name
  @override
  Future<void> updateSensor(Sensor sensor) async {
    Box box = await _openSensorBox();
    await box.put(sensor.sensorId, SensorModel.fromEntity(sensor));
  }
}
