import 'package:bolid_sample/src/shared/domain/use_cases/use_cases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/domain/entities/sensor.dart';
import '../../../domain/use_cases/get_sensors.dart';

part 'sensor_event.dart';

part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final GetSensors _getSensors;

  SensorBloc({
    required GetSensors getSensors,
  })  : _getSensors = getSensors,
        super(SensorLoading()) {
    on<SensorGetSensors>(_onSensorGetSensors);
  }

  void _onSensorGetSensors(SensorGetSensors event, Emitter<SensorState> emit) async {
    debugPrint('Getting sensors with _onSensorGetSensors');
    try {
      // Get sensors with _getSensors with no params (from domain layer)
      List<Sensor> sensors = await _getSensors(NoParams());
      debugPrint('Got sensors');
      // Return SensorLoaded state with sensors
      emit(SensorLoaded(sensors: sensors));
    } catch (error, stackTrace) {
      debugPrintStack(
        label: error.toString(),
        stackTrace: stackTrace,
      );
      // Return SensorFailure state error message
      emit(SensorFailure(message: error.toString()));
    }
  }
}
