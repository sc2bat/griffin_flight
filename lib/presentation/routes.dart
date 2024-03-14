import 'package:go_router/go_router.dart';
import 'package:griffin/di/get_it.dart';
import 'package:griffin/presentation/book/books/books_screen.dart';
import 'package:griffin/presentation/book/books/books_view_model.dart';
import 'package:griffin/presentation/book/passport/passport_screen.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/book/seat/seat_screen.dart';
import 'package:griffin/presentation/book/seat/seat_view_model.dart';
import 'package:griffin/presentation/index_screen.dart';
import 'package:griffin/presentation/my_books/my_books_screen.dart';
import 'package:griffin/presentation/my_books/my_books_view_model.dart';
import 'package:griffin/presentation/mypage/mypage_screen.dart';
import 'package:griffin/presentation/mypage/mypage_view_model.dart';
import 'package:griffin/presentation/navigation/navigation_screen.dart';
import 'package:griffin/presentation/pay/pay_screen.dart';
import 'package:griffin/presentation/pay/pay_view_model.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_screen.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_view_model.dart';
import 'package:griffin/presentation/search/search_screen.dart';
import 'package:griffin/presentation/search/search_view_model.dart';
import 'package:griffin/presentation/sign/sign_screen.dart';
import 'package:griffin/presentation/sign/sign_view_model.dart';
import 'package:griffin/presentation/splash/splash_screen.dart';
import 'package:griffin/presentation/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

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
      name: 'search',
      path: '/search',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SearchViewModel>(),
        child: const SearchScreen(),
      ),
      routes: [
        GoRoute(
          name: 'result',
          path: 'result',
          builder: (context, state) {
            if (state.extra != null) {
              final map = state.extra! as Map<String, dynamic>;
              return ChangeNotifierProvider(
                create: (_) => getIt<FlightResultViewModel>(),
                child: FlightResultScreen(
                  searchResult: map["search_result"] as Map<String, dynamic>,
                ),
              );
            } else {
              return const IndexScreen();
            }
          },
        ),
      ],
    ),
    GoRoute(
      name: 'book',
      path: '/book',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<BooksViewModel>(),
        child: const BooksScreen(),
      ),
      routes: [
        GoRoute(
            name: 'passport',
            path: 'passport',
            builder: (context, state) {
              if (state.extra != null) {
                final map = state.extra! as Map<String, dynamic>;
                return ChangeNotifierProvider(
                  create: (_) => getIt<PassportViewModel>(),
                  child: PassportScreen(
                    departureFlightList: map["departure_flight"],
                    arrivalFlightList: map["arrival_flight"],
                  ),
                );
              } else {
                return const IndexScreen();
              }
            },
            routes: [
              GoRoute(
                  name: 'seat',
                  path: 'seat',
                  builder: (context, state) {
                    if (state.extra != null) {
                      final map = state.extra! as Map<String, dynamic>;
                      return ChangeNotifierProvider(
                        create: (_) => getIt<SeatViewModel>(),
                        child: SeatScreen(
                          bookIdList: map['bookIdList'],
                        ),
                      );
                    } else {
                      return const IndexScreen();
                    }
                  }),
            ]),
      ],
    ),
    GoRoute(
      name: 'navigation',
      path: '/navigation',
      builder: (_, __) => const NavigationScreen(),
      routes: [
        GoRoute(
          name: 'myBooks',
          path: 'myBooks',
          builder: (_, __) => ChangeNotifierProvider(
              create: (_) => getIt<MyBooksViewModel>(),
              child: const MyBooksScreen()),
          routes: const [],
        ),
        GoRoute(
          name: 'mypage',
          path: 'mypage',
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => getIt<MypageViewModel>(),
            child: const MypageScreen(),
          ),
          routes: const [],
        ),
      ],
    ),
    GoRoute(
      name: 'pay',
      path: '/pay',
      builder: (_, state) {
        final map = state.extra! as Map<String, dynamic>;
        return ChangeNotifierProvider(
          create: (_) => getIt<PayViewModel>(),
          child: PayScreen(
            forPayBookIdList: map['bookIdList'],
          ),
        );
      },
      routes: const [],
    ),
  ],
);

List<String> routeList = [
  'navigation',
  'myBooks',
  'pay',
  'splash',
  'sign',
  'mypage',
];
