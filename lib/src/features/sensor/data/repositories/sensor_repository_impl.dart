import 'package:flutter/material.dart';
import '../../../../shared/domain/entities/sensor.dart';
import '../../domain/repositories/sensor_repository.dart';
import '../data/local_sensor_data_source.dart';
import '../data/mock_sensor_data_source.dart';

class SensorRepositoryImpl extends SensorRepository {
  final LocalSensorDataSource localSensorDataSource;
  final MockSensorDataSource mockSensorDataSource;

  SensorRepositoryImpl(
    this.localSensorDataSource,
    this.mockSensorDataSource,
  );

  @override
  Future<void> updateSensor(Sensor sensor) {
    return localSensorDataSource.updateSensor(sensor);
  }
  @override
  Future<List<Sensor>> getSensors() async {
    // TODO: Check internet connection. Get from database, if here is active connection Else get from local Hive
    // Get sensors from local database
    if ((await localSensorDataSource.getSensors()).isEmpty) {
      // if is empty - get from mock db then iterate to write each of them to local db
      List<Sensor> sensors = await mockSensorDataSource.getSensors();
      for (final sensor in sensors) {
        localSensorDataSource.addSensor(sensor);
      }
      return sensors;
    } else {
      debugPrint('Getting sensors from Hive');
      // if is not - parse from local db
      return localSensorDataSource.getSensors();
    }
  }

}
