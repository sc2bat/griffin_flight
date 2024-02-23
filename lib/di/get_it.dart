import 'package:get_it/get_it.dart';
import 'package:griffin/data/repositories/sample_repository_impl.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';
import 'package:griffin/domain/use_cases/sample_use_case.dart';
import 'package:griffin/presentation/book/book_screen_viewmodel.dart';
import 'package:griffin/presentation/counter/sample_view_model.dart';

import '../data/repositories/flight_repository_impl.dart';
import '../presentation/counter/counter_view_model.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // repository
  getIt.registerSingleton<SampleRepository>(
    SampleRepositoryImpl(),
  );

  getIt.registerSingleton<FlightRepository>(
    FlightRepositoryImpl(),
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
    ..registerFactory<SampleViewModel>(
      () => SampleViewModel(
        sampleUseCase: getIt<SampleUseCase>(),
      ),
    )
    ..registerFactory<BookScreenViewModel>(
          () => BookScreenViewModel(),
    );
}
