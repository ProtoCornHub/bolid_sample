import 'package:bolid_sample/src/shared/domain/entities/sensor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../domain/use_cases/update_sensor.dart';

part 'update_sensor_state.dart';

class UpdateSensorCubit extends Cubit<UpdateSensorState> {
  final UpdateSensor _updateSensor;

  UpdateSensorCubit({
    required UpdateSensor updateSensor,
  })  : _updateSensor = updateSensor,
        super(UpdateSensorState.initial());

  void sensorNameChanged(String value) {
    final sensorName = SensorName.dirty(value);
    emit(
      state.copyWith(
        sensorName: sensorName,
        status: Formz.validate(
          [
            sensorName,
          ],
        ),
      ),
    );
  }

  void updateSensor({Sensor? sensor}) async {
    debugPrint('Update sensor with updateSensor');
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      _updateSensor(
        UpdateSensorParams(
          sensor: sensor!.copyWith(
            name: state.sensorName.value,
          ),
        ),
      );
      debugPrint('The sensor has been updated.');
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } catch (error, stackTrace) {
      debugPrintStack(
        label: error.toString(),
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  void reset() {
    emit(UpdateSensorState.initial());
  }
}
