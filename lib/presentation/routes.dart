import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/counter/counter_screen.dart';

final router = GoRouter(
  initialLocation: '/counter',
  routes: [
    GoRoute(
      name: 'counter',
      path: '/counter',
      builder: (context, state) => CounterScreen(),
      routes: const [],
    ),
    // GoRoute(
    //   name: 'sample',
    //   path: '/sample',
    //   builder: (context, state) => SampleScreen(),
    // routes: const [],
    // ),
  ],
);
