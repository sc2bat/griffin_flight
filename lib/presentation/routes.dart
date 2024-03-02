import 'package:go_router/go_router.dart';
import 'package:griffin/di/get_it.dart';
import 'package:griffin/domain/model/payment_model.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';
import 'package:griffin/domain/model/flights_model.dart';
import 'package:griffin/presentation/book/book_screen.dart';
import 'package:griffin/presentation/book/book_data_test_screen.dart';
import 'package:griffin/presentation/book/book_screen_viewmodel.dart';
import 'package:griffin/presentation/counter/counter_screen.dart';
import 'package:griffin/presentation/counter/sample_screen.dart';
import 'package:griffin/presentation/index_screen.dart';
import 'package:griffin/presentation/mybooks/my_books_view_model.dart';
import 'package:griffin/presentation/pay/pay_screen.dart';
import 'mybooks/my_books_screen.dart';
import 'package:griffin/presentation/search/city_select_page.dart';
import 'package:griffin/presentation/search/flight_results.dart';
import 'package:griffin/presentation/search/search_screen.dart';
import 'package:provider/provider.dart';


final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'index',
      path: '/',
      builder: (context, state) => const IndexScreen(),
      routes: const [],
    ),
    GoRoute
      (
      name: 'search',
      path: '/search',
      builder: (context, state) => const SearchScreen(),
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
            builder: (context, state) {
              return ChangeNotifierProvider(
                  create: (_) => getIt<BookScreenViewModel>(),
              child: const BookScreen(), //보내는값
              );
            }
        ),
      ],
    ),


    GoRoute(
      name: 'myBooks',
      path: '/myBooks',
      builder: (context, state) => ChangeNotifierProvider(
          create: (_) => MyBooksViewModel(paymentRepository: getIt<PaymentRepository>()),
          child: const MyBooksScreen()),
      routes: const [],
    ),
    GoRoute(
      name: 'pay',
      path: '/pay',
      builder: (context, state) =>
          PayScreen(forPaymentList: state.extra as List<PaymentModel>),
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
  'myBooks',
  'pay',
  'sample',
];
