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
          // Listen SensorFailure to showSnackBar
          // It's more flexible for user than inside container
          if (state is SensorFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<SensorBloc, SensorState>(
          // Call SensorGetSensors event
          bloc: context.read<SensorBloc>()..add(SensorGetSensors()),
          builder: (context, state) {
            // SensorLoading state shows CircularProgressIndicator
            if (state is SensorLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SensorLoaded) {
              // Check sensors from state of SensorLoaded
              // if is not empty we'll show list of sensors
              // or text based message No sensors
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
    // Get color, text value from SensorColor using status
    final sensorColor = SensorColor.getColor(sensor.status);
    return ListTile(
      tileColor: sensorColor.withOpacity(0.2),
      onTap: () {
        // Go to SensorDetails route (with sensor extra)
        return context.go(
          context.namedLocation(
            'sensor_details',
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
