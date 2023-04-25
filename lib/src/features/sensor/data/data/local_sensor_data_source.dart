import 'package:hive/hive.dart';
import '../../../../shared/data/model/sensor_model.dart';
import '../../../../shared/domain/entities/sensor.dart';

abstract class LocalSensorDataSource {
  Future<void> addSensor(Sensor sensor);
  Future<List<Sensor>> getSensors();
  Future<void> updateSensor(Sensor sensor);
}

class LocalSensorDataSourceImpl implements LocalSensorDataSource {
  Future<Box> _openSensorBox() async {
    return Hive.openBox<SensorModel>('sensors');
  }

  @override
  Future<void> addSensor(Sensor sensor) async {
    Box box = await _openSensorBox();
    await box.put(sensor.sensorId, SensorModel.fromEntity(sensor));
  }

  @override
  Future<List<Sensor>> getSensors() async {
    Box<SensorModel> box = await _openSensorBox() as Box<SensorModel>;
    return box.values.toList().map((user) => user.toEntity()).toList();
  }

  @override
  Future<void> updateSensor(Sensor sensor) async {
    Box box = await _openSensorBox();
    await box.put(sensor.sensorId, SensorModel.fromEntity(sensor));
  }
}
