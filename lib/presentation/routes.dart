import 'package:go_router/go_router.dart';
import 'package:griffin/di/get_it.dart';
import 'package:griffin/domain/model/payment_model.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';
import 'package:griffin/presentation/book/book/book_screen.dart';
import 'package:griffin/presentation/book/passport/passport_screen.dart';
import 'package:griffin/presentation/book/seat/seat_screen.dart';
import 'package:griffin/presentation/counter/counter_screen.dart';
import 'package:griffin/presentation/counter/sample_screen.dart';
import 'package:griffin/presentation/index_screen.dart';
import 'package:griffin/presentation/mybooks/my_books_view_model.dart';
import 'package:griffin/presentation/mypage/mypage_screen.dart';
import 'package:griffin/presentation/mypage/mypage_view_model.dart';
import 'package:griffin/presentation/pay/pay_screen.dart';
import 'package:griffin/presentation/search/flight_results.dart';
import 'package:griffin/presentation/search/search_screen.dart';
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
      builder: (context, state) => const IndexScreen(),
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
      builder: (context, state) => ChangeNotifierProvider(
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
      builder: (context, state) => const SearchScreen(),
      routes: [
        GoRoute(
          name: 'flightResults',
          path: 'flightResults',
          builder: (context, state) => const FlightResults(),
        ),
      ],
    ),
    GoRoute(
      name: 'book',
      path: '/book',
      builder: (context, state) => const BookScreen(),
      routes: [
        GoRoute(
            name: 'passport',
            path: 'passport',
            builder: (context, state) => const PassportScreen(),
            routes: [
              GoRoute(
                name: 'seat',
                path: 'seat',
                builder: (context, state) => const SeatScreen(),
              ),
            ]),
      ],
    ),
    GoRoute(
      name: 'myBooks',
      path: '/myBooks',
      builder: (context, state) => ChangeNotifierProvider(
          create: (_) =>
              MyBooksViewModel(paymentRepository: getIt<PaymentRepository>()),
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
  'book',
  'myBooks',
  'pay',
  'sample',
  'splash',
  'sign',
  'mypage',
];
