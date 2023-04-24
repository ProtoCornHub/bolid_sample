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
  Future<void> addSensor(Sensor sensor) {
    return localSensorDataSource.addSensor(sensor);
  }

  @override
  Future<List<Sensor>> getSensors() async {
    // TODO: Check internet connection. Get from database, if here is active connection Else get from local Hive
    if ((await localSensorDataSource.getSensors()).isEmpty) {
      List<Sensor> sensors = await mockSensorDataSource.getSensors();
      for (final sensor in sensors) {
        localSensorDataSource.addSensor(sensor);
      }
      return sensors;
    } else {
      debugPrint('Getting sensors from Hive');
      return localSensorDataSource.getSensors();
    }
  }

}