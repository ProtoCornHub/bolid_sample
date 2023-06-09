import 'package:bolid_sample/src/features/sensor/data/data/mock_sensor_data_source.dart';
import 'package:bolid_sample/src/features/sensor/domain/use_cases/get_sensors.dart';
import 'package:bolid_sample/src/features/sensor/presentation/blocs/update_sensor/update_sensor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/config/app_router.dart';
import 'src/config/app_theme.dart';
import 'src/features/sensor/data/data/local_sensor_data_source.dart';
import 'src/features/sensor/data/repositories/sensor_repository_impl.dart';
import 'src/features/sensor/domain/use_cases/update_sensor.dart';
import 'src/features/sensor/presentation/blocs/sensor/sensor_bloc.dart';
import 'src/shared/data/model/sensor_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive in Flutter
  await Hive.initFlutter();
  // Register sensor model adapter with type 0
  Hive.registerAdapter(SensorModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SensorRepositoryImpl(
            LocalSensorDataSourceImpl(),
            MockSensorDataSourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SensorBloc(
              getSensors: GetSensors(
                context.read<SensorRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => UpdateSensorCubit(
              updateSensor: UpdateSensor(
                context.read<SensorRepositoryImpl>(),
              ),
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            // Create MaterialApp that uses the CustomTheme, AppRouter
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Bolid Sample',
              theme: CustomTheme().theme(),
              routerConfig: AppRouter().router,
            );
          }
        ),
      ),
    );
  }
}

