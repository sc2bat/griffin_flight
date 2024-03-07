import 'package:go_router/go_router.dart';
import 'package:griffin/di/get_it.dart';
import 'package:griffin/domain/model/payment_model.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';
import 'package:griffin/presentation/book/book/book_screen.dart';
import 'package:griffin/presentation/book/passport/passport_screen.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/book/seat/seat_screen.dart';
import 'package:griffin/presentation/counter/counter_screen.dart';
import 'package:griffin/presentation/counter/sample_screen.dart';
import 'package:griffin/presentation/index_screen.dart';
import 'package:griffin/presentation/mybooks/my_books_view_model.dart';
import 'package:griffin/presentation/mypage/mypage_screen.dart';
import 'package:griffin/presentation/mypage/mypage_view_model.dart';
import 'package:griffin/presentation/pay/pay_screen.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_view_model.dart';
import 'package:griffin/presentation/search/flight_result/flight_results.dart';
import 'package:griffin/presentation/search/search_screen.dart';
import 'package:griffin/presentation/search/search_view_model.dart';
import 'package:griffin/presentation/sign/sign_screen.dart';
import 'package:griffin/presentation/sign/sign_view_model.dart';
import 'package:griffin/presentation/splash/splash_screen.dart';
import 'package:griffin/presentation/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

import 'mybooks/my_books_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'index',
      path: '/',
      builder: (_, __) => const IndexScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SplashViewModel>(),
        child: const SplashScreen(),
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'sign',
      path: '/sign',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SignViewModel>(),
        child: const SignScreen(),
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'mypage',
      path: '/mypage',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<MypageViewModel>(),
        child: const MypageScreen(),
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'search',
      path: '/search',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SearchViewModel>(),
        child: const SearchScreen(),
      ),
      routes: [
        GoRoute(
          name: 'flightResults',
          path: 'flightResults',
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => getIt<FlightResultViewModel>(),
            child: const FlightResults(),
          ),
        ),
      ],
    ),
    GoRoute(
      name: 'book',
      path: '/book',
      builder: (_, __) => const BookScreen(),
      routes: [
        GoRoute(
            name: 'passport',
            path: 'passport',
            builder: (_, __) => ChangeNotifierProvider(
                  create: (_) => getIt<PassportViewModel>(),
                  child: const PassportScreen(),
                ),
            routes: [
              GoRoute(
                name: 'seat',
                path: 'seat',
                builder: (_, __) => const SeatScreen(),
              ),
            ]),
      ],
    ),
    GoRoute(
      name: 'myBooks',
      path: '/myBooks',
      builder: (_, __) => ChangeNotifierProvider(
          create: (_) => MyBooksViewModel(
                paymentRepository: getIt<PaymentRepository>(),
              ),
          child: const MyBooksScreen()),
      routes: const [],
    ),
    GoRoute(
      name: 'pay',
      path: '/pay',
      builder: (_, state) =>
          PayScreen(forPaymentList: state.extra as List<PaymentModel>),
      routes: const [],
    ),
    GoRoute(
      name: 'counter',
      path: '/counter',
      builder: (_, __) => CounterScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'sample',
      path: '/sample',
      builder: (_, __) => const SampleScreen(),
      routes: const [],
    ),
  ],
);

List<String> routeList = [
  'search',
  'book',
  'myBooks',
  'pay',
  'sample',
  'splash',
  'sign',
  'mypage',
];
