import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/use_cases/sample_use_case.dart';
import 'package:griffin/utils/simple_logger.dart';

class SampleViewModel extends StateNotifier<List<AirportModel>> {
  final SampleUseCase _sampleUseCase;
  SampleViewModel({
    required SampleUseCase sampleUseCase,
  })  : _sampleUseCase = sampleUseCase,
        super([]);

  void fetch() async {
    final fetchResult = await _sampleUseCase.execute();

    fetchResult.when(
      success: (List<AirportModel> data) {
        state = data;
      },
      error: (String message) {
        logger.info(message);
      },
    );
  }
}
