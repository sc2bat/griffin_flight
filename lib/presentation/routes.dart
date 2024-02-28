import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/book_screen.dart';
import 'package:griffin/presentation/book/book_data_test_screen.dart';
import 'package:griffin/presentation/counter/counter_screen.dart';
import 'package:griffin/presentation/counter/sample_screen.dart';
import 'package:griffin/presentation/index_screen.dart';
import 'package:griffin/presentation/pay/pay_screen.dart';
import 'package:griffin/presentation/search/city_select_page.dart';
import 'package:griffin/presentation/search/flight_results.dart';
import 'package:griffin/presentation/search/search_screen.dart';
import 'package:griffin/presentation/search/search_view_model.dart';
import 'package:provider/provider.dart';

import '../di/get_it.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'index',
      path: '/',
      builder: (context, state) => const IndexScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'search',
      path: '/search',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<SearchViewModel>(),
        child: const SearchScreen(),
      ),
      routes: [
        GoRoute(
          name: 'flightResults',
          path: 'flightResults',
          builder: (context, state) => FlightResults(),
        ),
      ],
    ),
    GoRoute(
      name: 'book_data_test',
      path: '/book_data_test',
      builder: (context, state) => const BookDataTestScreen(),
      routes: [
        GoRoute(
          name: 'book',
          path: 'book',
          builder: (context, state) => BookScreen(),
        ),
      ],
    ),
    GoRoute(
      name: 'pay',
      path: '/pay',
      builder: (context, state) => PayScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'counter',
      path: '/counter',
      builder: (context, state) => CounterScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'sample',
      path: '/sample',
      builder: (context, state) => const SampleScreen(),
      routes: const [],
    ),
  ],
);

List<String> routeList = [
  'search',
  'book_data_test',
  'pay',
  'sample',
];
