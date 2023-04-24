import 'package:bolid_sample/src/shared/data/data_sources/sensor_data.dart';
import '../../../../shared/data/model/sensor_model.dart';
import '../../../../shared/domain/entities/sensor.dart';

abstract class MockSensorDataSource {
  Future<List<Sensor>> getSensors();
}

class MockSensorDataSourceImpl implements MockSensorDataSource {
  @override
  Future<List<Sensor>> getSensors() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return sensors.map((product) {
      return SensorModel.fromJson(product).toEntity();
    }).toList();
  }
}
