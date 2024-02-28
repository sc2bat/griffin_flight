import 'package:get_it/get_it.dart';
import 'package:griffin/data/repositories/airport_repository_impl.dart';
import 'package:griffin/data/repositories/sample_repository_impl.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';
import 'package:griffin/domain/use_cases/sample_use_case.dart';
import 'package:griffin/presentation/counter/sample_view_model.dart';
import 'package:griffin/presentation/search/search_view_model.dart';

import '../presentation/counter/counter_view_model.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // repository
  getIt.registerSingleton<SampleRepository>(
    SampleRepositoryImpl(),
  );
  getIt.registerSingleton<AirportRepository>(
    AirportRepositoryImpl(),
  );

  // use case
  getIt.registerSingleton<SampleUseCase>(
    SampleUseCase(sampleRepository: getIt<SampleRepository>()),
  );

  // view models
  getIt
    ..registerFactory<CounterViewModel>(
      () => CounterViewModel(),
    )
    ..registerFactory<SearchViewModel>(
      () => SearchViewModel(repository: getIt<AirportRepository>()),
    )
    ..registerFactory<SampleViewModel>(
      () => SampleViewModel(
        sampleUseCase: getIt<SampleUseCase>(),
      ),
    );
}
