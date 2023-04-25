import 'package:bolid_sample/src/shared/domain/entities/sensor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/update_sensor.dart';

part 'update_sensor_state.dart';

class UpdateSensorCubit extends Cubit<UpdateSensorState> {
  final UpdateSensor _updateSensor;

  UpdateSensorCubit({
    required UpdateSensor updateSensor,
  })  : _updateSensor = updateSensor,
        super(UpdateSensorState.initial());

  void sensorNameChanged(String value) {
    emit(state.copyWith(
      sensorName: value,
      status: UpdateSensorStatus.initial,
    ));
  }

  void updateSensor({Sensor? sensor}) async {
    debugPrint('Update sensor with updateSensor');
    emit(
      state.copyWith(
        status: UpdateSensorStatus.loading,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      _updateSensor(
        UpdateSensorParams(
          sensor: sensor!.copyWith(
            name: state.sensorName,
          ),
        ),
      );
      debugPrint('The sensor has been updated.');
      emit(
        state.copyWith(
          status: UpdateSensorStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      debugPrintStack(
        label: error.toString(),
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: UpdateSensorStatus.error,
          errorText: error.toString(),
        ),
      );
    }
  }

  void reset() {
    emit(UpdateSensorState.initial());
  }
}
