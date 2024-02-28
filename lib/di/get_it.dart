import 'package:get_it/get_it.dart';
import 'package:griffin/data/repositories/sample_repository_impl.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';
import 'package:griffin/domain/use_cases/detail_use_case.dart';
import 'package:griffin/domain/use_cases/sample_use_case.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/counter/sample_view_model.dart';

import '../data/repositories/flight_repository_impl.dart';
import '../data/repositories/passport_repository_imple.dart';
import '../domain/repositories/passport_repository.dart';
import '../presentation/book/detail/detail_viewmodel.dart';
import '../presentation/counter/counter_view_model.dart';
import 'package:griffin/domain/use_cases/passport_use_case.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // repository
  getIt
    ..registerSingleton<SampleRepository>(
      SampleRepositoryImpl(),
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
      SampleUseCase(sampleRepository: getIt<SampleRepository>()),
    )
    ..registerSingleton<PassportUsecase>(
      PassportUsecase(passportRepository: getIt<PassportRepository>()),
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
    ..registerFactory<DetailViewModel>(
      () => DetailViewModel(detailUseCase: getIt<DetailUseCase>()
      ),
    )
  ..registerFactory<PassportViewModel>(
      () => PassportViewModel(passportUsecase: getIt<PassportUsecase>()
      ),
  );
}
