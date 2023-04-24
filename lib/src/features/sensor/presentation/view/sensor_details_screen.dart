import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/sensor.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';

class SensorDetailsScreen extends StatelessWidget {
  const SensorDetailsScreen({Key? key, required this.sensor}) : super(key: key);
  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: sensor.name,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: [
            _DetailCard(
              title: 'Status',
              label: sensor.status.toString(),
            ),
            const SizedBox(height: 20),
            _DetailCard(
              title: 'Temperature',
              label: sensor.temperature.toString(),
            ),
            const SizedBox(height: 20),
            _DetailCard(
              title: 'Humidity',
              label: sensor.humidity.toString(),
            ),
          ],
        ),
      ),
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
