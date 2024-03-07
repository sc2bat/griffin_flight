import 'package:get_it/get_it.dart';
import 'package:griffin/data/repositories/sample_repository_impl.dart';
import 'package:griffin/data/repositories/session_repository_impl.dart';
import 'package:griffin/data/repositories/sign_repository_impl.dart';
import 'package:griffin/data/repositories/user_repository_impl.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';
import 'package:griffin/domain/repositories/session_repository.dart';
import 'package:griffin/domain/repositories/sign_repository.dart';
import 'package:griffin/domain/repositories/user_repository.dart';
import 'package:griffin/domain/use_cases/airport/airport_list_use_case.dart';
import 'package:griffin/domain/use_cases/sample_use_case.dart';
import 'package:griffin/domain/use_cases/search/search_flight_use_case.dart';
import 'package:griffin/domain/use_cases/sign/save_session_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_in_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_up_use_case.dart';
import 'package:griffin/domain/use_cases/splash/get_session_use_case.dart';
import 'package:griffin/domain/use_cases/splash/splash_get_user_info_use_case.dart';
import 'package:griffin/presentation/counter/sample_view_model.dart';
import 'package:griffin/presentation/mypage/mypage_view_model.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_view_model.dart';
import 'package:griffin/presentation/sign/sign_view_model.dart';
import 'package:griffin/presentation/splash/splash_view_model.dart';

import '../data/repositories/airport_repository_impl.dart';
import '../data/repositories/flight_repository_impl.dart';
import '../data/repositories/passport_repository_imple.dart';
import '../data/repositories/payment_repository_impl.dart';
import '../domain/repositories/airport_repository.dart';
import '../domain/repositories/passport_repository.dart';
import '../domain/repositories/payment_repository.dart';
import '../domain/use_cases/detail_use_case.dart';
import '../domain/use_cases/passport_use_case.dart';
import '../presentation/book/book/book_viewmodel.dart';
import '../presentation/book/passport/passport_view_model.dart';
import '../presentation/counter/counter_view_model.dart';
import '../presentation/mybooks/my_books_view_model.dart';
import '../presentation/search/search_view_model.dart';

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
    ..registerSingleton<SignRepository>(
      SignRepositoryImpl(),
    )
    ..registerSingleton<PaymentRepository>(
      PaymentRepositoryImpl(),
    )
    ..registerSingleton<AirportRepository>(
      AirportRepositoryImpl(),
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
    ..registerSingleton<GetSessionUseCase>(
      GetSessionUseCase(
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerSingleton<SaveSessionUseCase>(
      SaveSessionUseCase(
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerSingleton<SignUpUseCase>(
      SignUpUseCase(
        signRepository: getIt<SignRepository>(),
      ),
    )
    ..registerSingleton<SignInUseCase>(
      SignInUseCase(
        signRepository: getIt<SignRepository>(),
      ),
    )
    ..registerSingleton<SplashGetUserInfoUseCase>(
      SplashGetUserInfoUseCase(
        userRepository: getIt<UserRepository>(),
      ),
    )
    ..registerSingleton<AirportListUseCase>(
      AirportListUseCase(
        airportRepository: getIt<AirportRepository>(),
      ),
    )
    ..registerSingleton<SearchFlightUseCase>(
      SearchFlightUseCase(
        flightRepository: getIt<FlightRepository>(),
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
    ..registerFactory<SearchViewModel>(
      () => SearchViewModel(
        getSessionUseCase: getIt<GetSessionUseCase>(),
        airportListUseCase: getIt<AirportListUseCase>(),
      ),
    )
    ..registerFactory<FlightResultViewModel>(
      () => FlightResultViewModel(
        searchFlightUseCase: getIt<SearchFlightUseCase>(),
      ),
    )
    ..registerFactory<SampleViewModel>(
      () => SampleViewModel(
        sampleUseCase: getIt<SampleUseCase>(),
      ),
    )
    ..registerFactory<SplashViewModel>(
      () => SplashViewModel(
        getSessionUseCase: getIt<GetSessionUseCase>(),
        splashGetUserInfoUseCase: getIt<SplashGetUserInfoUseCase>(),
      ),
    )
    ..registerFactory<SignViewModel>(
      () => SignViewModel(
        signUpUseCase: getIt<SignUpUseCase>(),
        signInUseCase: getIt<SignInUseCase>(),
        saveSessionUseCase: getIt<SaveSessionUseCase>(),
      ),
    )
    ..registerFactory<MypageViewModel>(
      () => MypageViewModel(),
    )
    ..registerFactory<MyBooksViewModel>(
      () => MyBooksViewModel(
        paymentRepository: getIt<PaymentRepository>(),
      ),
    )
    ..registerFactory<BookViewModel>(
      () => BookViewModel(
        detailUseCase: getIt<DetailUseCase>(),
      ),
    )
    ..registerFactory<PassportViewModel>(
      () => PassportViewModel(
        passportUsecase: getIt<PassportUsecase>(),
      ),
    );

  // ----------------- Airport Start -----------------
  // Airport Repositories
  //getIt.registerLazySingleton<AirportRepository>(() => AirportRepositoryImpl());
  // Airport Usecase
  //getIt.registerLazySingleton(() => GetAirportUsecase(repository: getIt<AirportRepository>()));
  // Airport Provider
  //getIt.registerFactory(() => AirportProvider(getAirportUsecase: getIt<GetAirportUsecase>()),);
  // ----------------- Airport End -----------------
}
