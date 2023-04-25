import 'package:bolid_sample/src/features/sensor/presentation/blocs/sensor/sensor_bloc.dart';
import 'package:bolid_sample/src/shared/domain/entities/sensor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/presentation/utils/sensor_color.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';

class SensorListScreen extends StatelessWidget {
  const SensorListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sensors',
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<SensorBloc, SensorState>(
        listener: (context, state) {
          if (state is SensorFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<SensorBloc, SensorState>(
          bloc: context.read<SensorBloc>()..add(SensorGetSensors()),
          builder: (context, state) {
            if (state is SensorLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SensorLoaded) {
              if (state.sensors.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.sensors.length,
                  itemBuilder: (context, index) {
                    final sensor = state.sensors[index];
                    return _SensorCard(sensor: sensor);
                  },
                );
              } else {
                return const Center(
                  child: Text('No sensors'),
                );
              }
            }
            return const Center(
              child: Text('Something went wrong.'),
            );
          },
        ),
      ),
    );
  }
}

class _SensorCard extends StatelessWidget {
  const _SensorCard({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    final sensorColor = SensorColor.getColor(sensor.status);
    return ListTile(
      tileColor: sensorColor.withOpacity(0.2),
      onTap: () {
        return context.go(
          context.namedLocation(
            'sensor_details_screen',
          ),
          extra: sensor,
        );
      },
      title: Text(sensor.name),
      subtitle: Text(SensorColor.getValue(sensor.status)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 15,
      ),
    );
  }
}
