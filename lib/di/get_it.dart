import 'package:get_it/get_it.dart';
import 'package:griffin/data/repositories/sample_repository_impl.dart';
import 'package:griffin/data/repositories/session_repository_impl.dart';
import 'package:griffin/data/repositories/user_repository_impl.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';
import 'package:griffin/domain/repositories/session_repository.dart';
import 'package:griffin/domain/repositories/user_repository.dart';
import 'package:griffin/domain/use_cases/sample_use_case.dart';
import 'package:griffin/domain/use_cases/splash/splash_get_session_use_case.dart';
import 'package:griffin/domain/use_cases/splash/splash_get_user_info_use_case.dart';
import 'package:griffin/presentation/counter/sample_view_model.dart';
import 'package:griffin/presentation/splash/splash_view_model.dart';

import '../data/repositories/flight_repository_impl.dart';
import '../data/repositories/passport_repository_imple.dart';
import '../data/repositories/payment_repository_impl.dart';
import '../domain/repositories/passport_repository.dart';
import '../domain/repositories/payment_repository.dart';
import '../domain/use_cases/detail_use_case.dart';
import '../domain/use_cases/passport_use_case.dart';
import '../presentation/book/book/book_viewmodel.dart';
import '../presentation/book/passport/passport_view_model.dart';
import '../presentation/counter/counter_view_model.dart';
import '../presentation/mybooks/my_books_view_model.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // repository
  getIt
    ..registerSingleton<SampleRepository>(
      SampleRepositoryImpl(),
    )
    ..registerSingleton<SessionRepository>(
      SessionRepositoryImpl(),
    )
    ..registerSingleton<UserRepository>(
      UserRepositoryImpl(),
    )
    ..registerSingleton<PaymentRepository>(
      PaymentRepositoryImpl(),
    )
    ..registerSingleton<FlightRepository>(
      FlightRepositoryImpl(),
    )
    ..registerSingleton<PassportRepository>(
      PassportRepositoryImpl(),
    );

  // use case
  getIt
    ..registerSingleton<SampleUseCase>(
      SampleUseCase(
        sampleRepository: getIt<SampleRepository>(),
      ),
    )
    ..registerSingleton<SplashGetSessionUseCase>(
      SplashGetSessionUseCase(
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerSingleton<SplashGetUserInfoUseCase>(
      SplashGetUserInfoUseCase(
        userRepository: getIt<UserRepository>(),
      ),
    )
    ..registerSingleton<PassportUsecase>(
      PassportUsecase(
        passportRepository: getIt<PassportRepository>(),
      ),
    );

  // view models
  getIt
    ..registerFactory<CounterViewModel>(
      () => CounterViewModel(),
    )
    ..registerFactory<SampleViewModel>(
      () => SampleViewModel(
        sampleUseCase: getIt<SampleUseCase>(),
      ),
    )
    ..registerFactory<SplashViewModel>(
      () => SplashViewModel(
        splashGetSessionUseCase: getIt<SplashGetSessionUseCase>(),
        splashGetUserInfoUseCase: getIt<SplashGetUserInfoUseCase>(),
      ),
    )
    ..registerFactory<MyBooksViewModel>(
        () => MyBooksViewModel(paymentRepository: getIt<PaymentRepository>()))
    ..registerFactory<BookViewModel>(
      () => BookViewModel(detailUseCase: getIt<DetailUseCase>()),
    )
    ..registerFactory<PassportViewModel>(
      () => PassportViewModel(passportUsecase: getIt<PassportUsecase>()),
    );
}
