import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/entities/sensor.dart';
import '../../../../shared/presentation/utils/sensor_color.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';
import '../blocs/sensor/sensor_bloc.dart';
import '../blocs/update_sensor/update_sensor_cubit.dart';

class SensorDetailsScreen extends StatefulWidget {
  const SensorDetailsScreen({Key? key, required this.sensor}) : super(key: key);
  final Sensor sensor;

  @override
  State<SensorDetailsScreen> createState() => _SensorDetailsScreenState();
}

class _SensorDetailsScreenState extends State<SensorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.sensor.name,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              buildShowModalBottomSheet(
                context: context,
                sensor: widget.sensor,
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: [
            _DetailCard(
              title: 'Status',
              label: SensorColor.getValue(widget.sensor.status),
            ),
            const SizedBox(height: 20),
            _DetailCard(
              title: 'Temperature, °C',
              label: widget.sensor.temperature.toString(),
            ),
            const SizedBox(height: 20),
            _DetailCard(
              title: 'Humidity, %',
              label: widget.sensor.humidity.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet({
    required BuildContext context,
    required Sensor sensor,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (newContext) {
        return Builder(builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(175),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit sensor name',
                  style: Theme.of(newContext).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                _Name(sensor: sensor),
                const SizedBox(height: 10),
                _Button(
                  sensor: sensor,
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class _Name extends StatefulWidget {
  const _Name({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  @override
  State<_Name> createState() => _NameState();
}

class _NameState extends State<_Name> {
  final sensorNameController = TextEditingController();

  @override
  void initState() {
    sensorNameController.text = widget.sensor.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: sensorNameController,
            maxLines: 1,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              context.read<UpdateSensorCubit>().sensorNameChanged(value);
            },
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocListener<UpdateSensorCubit, UpdateSensorState>(
          listener: (context, state) {
            if (state.status == UpdateSensorStatus.success) {
              Navigator.of(context).pop();
              context.read<SensorBloc>().add(SensorGetSensors());
              context.goNamed('sensor_list');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sensor updated!')),
              );
            } else if (state.status == UpdateSensorStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorText!),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: BlocBuilder<UpdateSensorCubit, UpdateSensorState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == UpdateSensorStatus.loading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  if (state.sensorName.isNotEmpty) {
                    context
                        .read<UpdateSensorCubit>()
                        .updateSensor(sensor: sensor);
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Field must not be empty or old'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    super.key,
    required this.title,
    required this.label,
  });

  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
