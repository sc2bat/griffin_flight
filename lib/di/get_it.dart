import 'package:get_it/get_it.dart';

import '../presentation/counter/counter_view_model.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // view models
  getIt.registerFactory<CounterViewModel>(
    () => CounterViewModel(),
  );
}
