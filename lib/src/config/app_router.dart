import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/sensor/presentation/view/sensor_details_screen.dart';
import '../features/sensor/presentation/view/sensor_list_screen.dart';
import '../shared/domain/entities/sensor.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'sensor_list',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return customTransitionPage<void>(
            context: context,
            state: state,
            child: const SensorListScreen(),
          );
        },
        routes: [
          GoRoute(
            name: 'sensor_details',
            path: 'sensor_details',
            pageBuilder: (BuildContext context, GoRouterState state) {
              Sensor sensor = state.extra as Sensor;
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: SensorDetailsScreen(sensor: sensor),
              );
            },
          ),
        ],
      ),
    ],
  );

  CustomTransitionPage customTransitionPage<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Change the opacity of the screen using a Curve based on the the animation's
        // value
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}
