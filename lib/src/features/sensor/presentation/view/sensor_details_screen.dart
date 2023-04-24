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
      body: Container(),
    );
  }
}
