import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/di/get_it.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';
import 'package:griffin/domain/use_cases/sample_use_case.dart';
import 'package:griffin/presentation/counter/sample_view_model.dart';

final sampleUseCaseProvider = Provider<SampleUseCase>((ref) {
  return SampleUseCase(sampleRepository: getIt<SampleRepository>());
});

final sampleProvider =
    StateNotifierProvider<SampleViewModel, List<AirportModel>>((ref) {
  final sampleUseCase = ref.read(sampleUseCaseProvider);
  return SampleViewModel(sampleUseCase: sampleUseCase);
});
